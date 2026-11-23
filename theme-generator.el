;;; theme-generator.el --- Theme generator for modern-themes -*- lexical-binding:t -*-

;; Copyright (C) 2025 Free Software Foundation, Inc.

;;; Commentary:
;;
;; This generator creates Emacs themes compatible with modus-themes structure.
;; It takes a minimal palette (bg-main, fg-main, accent colors) and generates
;; a complete theme file with all derived colors (warmer, cooler, faint variants).
;;
;; Usage:
;;   (modern-generate-theme
;;    :name "my-theme"
;;    :variant 'dark
;;    :description "My custom theme."
;;    :palette
;;    '(bg-main "#24283b"
;;      fg-main "#c0caf5"
;;      red     "#f7768e"
;;      green   "#9ece6a"
;;      ...)
;;    :syntax
;;    '(fnname red        ; override default: fnname uses red instead of blue
;;      keyword cyan))    ; override default: keyword uses cyan instead of magenta-cooler
;;
;; Result is copied to clipboard.

;;; Code:

(require 'cl-lib)
(require 'color)
(require 'subr-x)

(defgroup modern-theme-generator nil
  "Theme generator for modern-themes."
  :group 'faces)

(defcustom modern-theme-generator-minimum-contrast 4.5
  "Minimum WCAG contrast ratio for generated foreground colors.
The generator adjusts foreground and accent colors toward black or white
until they reach this ratio against `bg-main'.  Set this to 1.0 to
preserve palette colors without contrast correction."
  :group 'modern-theme-generator
  :type 'number)

;;; --- Color utilities ---

(defun mtg--hex-p (s)
  "Return non-nil if S is a valid hex color string."
  (and (stringp s)
       (string-match-p "\\`#[0-9A-Fa-f]\\{6\\}\\'" s)))

(defun mtg--rgb (hex)
  "Convert HEX color to RGB list (0.0-1.0 range)."
  (unless (mtg--hex-p hex)
    (error "Invalid hex color: %S" hex))
  (let* ((hex-clean (substring hex 1))
         (r (string-to-number (substring hex-clean 0 2) 16))
         (g (string-to-number (substring hex-clean 2 4) 16))
         (b (string-to-number (substring hex-clean 4 6) 16)))
    (list (/ r 255.0) (/ g 255.0) (/ b 255.0))))

(defun mtg--hex (rgb)
  "Convert RGB list to hex color string."
  (apply #'color-rgb-to-hex (append rgb '(2))))

(defun mtg--clamp01 (x)
  "Clamp X to [0.0, 1.0] range."
  (max 0.0 (min 1.0 x)))

(defun mtg--lighten (hex percent)
  "Lighten HEX color by PERCENT."
  (let* ((rgb (mtg--rgb hex))
         (p (/ (float percent) 100.0)))
    (mtg--hex (mapcar (lambda (c) (mtg--clamp01 (+ c (* p (- 1.0 c))))) rgb))))

(defun mtg--darken (hex percent)
  "Darken HEX color by PERCENT."
  (let* ((rgb (mtg--rgb hex))
         (p (/ (float percent) 100.0)))
    (mtg--hex (mapcar (lambda (c) (mtg--clamp01 (* c (- 1.0 p)))) rgb))))

(defun mtg--desaturate (hex percent)
  "Desaturate HEX color by PERCENT."
  (let* ((rgb (mtg--rgb hex))
         (hsl (apply #'color-rgb-to-hsl rgb))
         (s2 (mtg--clamp01 (- (nth 1 hsl) (/ (abs percent) 100.0)))))
    (mtg--hex (color-hsl-to-rgb (nth 0 hsl) s2 (nth 2 hsl)))))

(defun mtg--hue-shift (hex deg)
  "Shift hue of HEX color by DEG degrees."
  (let* ((rgb (mtg--rgb hex))
         (hsl (apply #'color-rgb-to-hsl rgb))
         (new-h (mod (+ (nth 0 hsl) (/ (float deg) 360.0)) 1.0)))
    (mtg--hex (color-hsl-to-rgb new-h (nth 1 hsl) (nth 2 hsl)))))

(defun mtg--blend (hex-a hex-b alpha)
  "Blend HEX-A and HEX-B colors with ALPHA (0-1, where 1 = full HEX-B)."
  (let* ((a (mtg--rgb hex-a))
         (b (mtg--rgb hex-b))
         (alpha (mtg--clamp01 (float alpha))))
    (mtg--hex
     (cl-mapcar (lambda (x y) (+ (* x (- 1.0 alpha)) (* y alpha))) a b))))

(defun mtg--relative-luminance (hex)
  "Return the WCAG relative luminance of HEX."
  (let ((channels
         (mapcar (lambda (channel)
                   (if (<= channel 0.04045)
                       (/ channel 12.92)
                     (expt (/ (+ channel 0.055) 1.055) 2.4)))
                 (mtg--rgb hex))))
    (+ (* 0.2126 (nth 0 channels))
       (* 0.7152 (nth 1 channels))
       (* 0.0722 (nth 2 channels)))))

(defun mtg--contrast-ratio (hex-a hex-b)
  "Return the WCAG contrast ratio between HEX-A and HEX-B."
  (let ((a (mtg--relative-luminance hex-a))
        (b (mtg--relative-luminance hex-b)))
    (/ (+ (max a b) 0.05)
       (+ (min a b) 0.05))))

(defun mtg--ensure-contrast (foreground background minimum-ratio)
  "Make FOREGROUND readable against BACKGROUND at MINIMUM-RATIO.
Return FOREGROUND unchanged when it already meets the requested WCAG
contrast.  Otherwise blend it toward whichever of black or white has
more contrast with BACKGROUND."
  (if (>= (mtg--contrast-ratio foreground background) minimum-ratio)
      foreground
    (let* ((black "#000000")
           (white "#ffffff")
           (target (if (> (mtg--contrast-ratio black background)
                          (mtg--contrast-ratio white background))
                       black
                     white))
           (target-ratio (mtg--contrast-ratio target background))
           (low 0.0)
           (high 1.0)
           result)
      (when (< target-ratio minimum-ratio)
        (error "Contrast %.1f cannot be reached against %s (maximum %.2f)"
               minimum-ratio background target-ratio))
      ;; Find the smallest adjustment that reaches the requested ratio.
      (dotimes (_ 24)
        (let* ((alpha (/ (+ low high) 2.0))
               (candidate (mtg--blend foreground target alpha)))
          (if (>= (mtg--contrast-ratio candidate background) minimum-ratio)
              (setq high alpha
                    result candidate)
            (setq low alpha))))
      (or result target))))

(defun mtg--normalize-foreground-palette (palette minimum-ratio)
  "Ensure foreground colors in PALETTE meet MINIMUM-RATIO.
Only colors intended for text are adjusted; background, border, and
cursor colors retain their original values."
  (let ((result (copy-sequence palette))
        (background (mtg--plist-get palette 'bg-main)))
    (dolist (key '(fg-main fg-dim fg-alt))
      (when-let* ((color (mtg--plist-get palette key)))
        (setq result
              (plist-put result key
                         (mtg--ensure-contrast color background minimum-ratio)))))
    result))

(defun mtg--warmer (hex &optional deg)
  "Make HEX color warmer by shifting hue towards red/orange.
DEG defaults to 5 degrees (subtle shift)."
  (mtg--hue-shift hex (or deg 5)))

(defun mtg--cooler (hex &optional deg)
  "Make HEX color cooler by shifting hue towards blue.
DEG defaults to -5 degrees (subtle shift)."
  (mtg--hue-shift hex (or deg -5)))

(defun mtg--faint (hex &optional amount)
  "Make HEX color faint (desaturated and darker).
AMOUNT defaults to 25."
  (let ((amt (or amount 25)))
    (mtg--darken (mtg--desaturate hex (* amt 0.7)) (* 0.25 amt))))

;;; --- Palette helpers ---

(defun mtg--plist-get (plist key)
  "Get value for KEY from PLIST."
  (plist-get plist key))

(defun mtg--plist-keys (plist)
  "Return all keys from PLIST."
  (let (keys)
    (while plist
      (push (car plist) keys)
      (setq plist (cddr plist)))
    (nreverse keys)))

;;; --- Color expressions ---
;;
;; Allows using expressions like:
;;   (darken bg-main 10)
;;   (lighten red 20)
;;   (blend bg-main blue 0.3)
;;   (warmer green 5)
;;   (cooler magenta)
;;   (faint yellow 30)
;;   (desaturate cyan 25)
;;   (hue-shift red 15)

(defun mtg--eval-color-expr (expr palette)
  "Evaluate color EXPR using colors from PALETTE.
EXPR can be:
  - A hex string like \"#ff0000\"
  - A symbol referring to a palette key like 'bg-main
  - A list expression like (darken bg-main 10)

Supported expressions:
  (darken COLOR PERCENT)     - Darken color by percent
  (lighten COLOR PERCENT)    - Lighten color by percent
  (blend COLOR1 COLOR2 ALPHA) - Blend two colors (0-1, 1=full COLOR2)
  (warmer COLOR [DEG])       - Shift hue towards red/orange
  (cooler COLOR [DEG])       - Shift hue towards blue
  (faint COLOR [AMOUNT])     - Desaturate and darken
  (desaturate COLOR PERCENT) - Reduce saturation
  (hue-shift COLOR DEG)      - Shift hue by degrees"
  (cond
   ;; Already a hex color
   ((mtg--hex-p expr) expr)
   ;; Symbol - lookup in palette
   ((symbolp expr)
    (let ((val (mtg--plist-get palette expr)))
      (if val
          (mtg--eval-color-expr val palette)
        (error "Unknown palette key: %s" expr))))
   ;; List expression
   ((listp expr)
    (let ((fn (car expr))
          (args (cdr expr)))
      (pcase fn
        ('darken
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (percent (nth 1 args)))
           (mtg--darken color percent)))
        ('lighten
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (percent (nth 1 args)))
           (mtg--lighten color percent)))
        ('blend
         (let ((color1 (mtg--eval-color-expr (nth 0 args) palette))
               (color2 (mtg--eval-color-expr (nth 1 args) palette))
               (alpha (nth 2 args)))
           (mtg--blend color1 color2 alpha)))
        ('warmer
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (deg (or (nth 1 args) 5)))
           (mtg--warmer color deg)))
        ('cooler
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (deg (or (nth 1 args) 5)))
           (mtg--cooler color deg)))
        ('faint
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (amount (or (nth 1 args) 25)))
           (mtg--faint color amount)))
        ('desaturate
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (percent (nth 1 args)))
           (mtg--desaturate color percent)))
        ('hue-shift
         (let ((color (mtg--eval-color-expr (nth 0 args) palette))
               (deg (nth 1 args)))
           (mtg--hue-shift color deg)))
        (_
         (error "Unknown color function: %s" fn)))))
   (t (error "Invalid color expression: %S" expr))))

(defun mtg--resolve-palette (palette)
  "Resolve all color expressions in PALETTE.
Returns a new plist with all expressions evaluated to hex colors."
  (let ((result nil)
        (keys (mtg--plist-keys palette)))
    ;; First pass: collect all raw hex values
    (dolist (key keys)
      (let ((val (mtg--plist-get palette key)))
        (when (mtg--hex-p val)
          (setq result (plist-put result key val)))))
    ;; Second pass: resolve expressions (may reference first pass values)
    (dolist (key keys)
      (let ((val (mtg--plist-get palette key)))
        (unless (mtg--hex-p val)
          (setq result (plist-put result key
                                  (mtg--eval-color-expr val result))))))
    result))

;;; --- Default values ---

(defconst mtg--accent-keys
  '(red orange green yellow blue magenta cyan)
  "Primary accent color keys.")

(defconst mtg--default-syntax-mapping
  '(keyword magenta-cooler
            fnname blue
            fnname-call blue
            variable red
            property blue
            string green
            type yellow
            constant red
            builtin blue
            comment fg-dim
            docstring fg-dim
            preprocessor blue
            rx-backslash cyan
            rx-construct red)
  "Default syntax to color mapping.")

(defconst mtg--palette-common
  '((fringe unspecified)
    (fg-region unspecified)

    (bg-diff-context bg-main)
    (bg-diff-focus bg-dim)
    (bg-diff-text bg-active)
    (fg-added unspecified)
    (fg-changed unspecified)
    (fg-removed unspecified)

    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-active)

    (fg-link-symbolic fg-alt)
    (underline-link border)
    (underline-link-symbolic border)

    (border-mode-line-active border)
    (bg-mode-line-inactive bg-alt)
    (fg-mode-line-inactive fg-dim)
    (border-mode-line-inactive border)

    (bg-line-number-active unspecified)
    (fg-line-number-active accent-0)
    (bg-line-number-inactive unspecified)

    (bg-prominent-err bg-err)
    (bg-prominent-warning bg-warning)
    (bg-prominent-note bg-info)
    (fg-prominent-err err)
    (fg-prominent-warning warning)
    (fg-prominent-note info)

    (bg-space unspecified)
    (fg-space border)

    (bg-active-argument bg-warning)
    (fg-active-argument warning)
    (bg-active-value bg-info)
    (fg-active-value info)

    (bg-mark-delete bg-err)
    (fg-mark-delete err)
    (bg-mark-select bg-info)
    (fg-mark-select info)
    (bg-mark-other bg-warning)
    (fg-mark-other warning)

    (fg-search-current bg-main)
    (fg-search-lazy fg-main)
    (fg-search-static fg-main)
    (fg-search-replace fg-main)

    (fg-search-rx-group-0 fg-main)
    (fg-search-rx-group-1 fg-main)
    (fg-search-rx-group-2 fg-main)
    (fg-search-rx-group-3 fg-main)

    (fg-completion-match-0 accent-0)
    (fg-completion-match-1 accent-1)
    (fg-completion-match-2 accent-2)
    (fg-completion-match-3 accent-3)

    (fg-heading-0 rainbow-0)
    (fg-heading-1 rainbow-1)
    (fg-heading-2 rainbow-2)
    (fg-heading-3 rainbow-3)
    (fg-heading-4 rainbow-4)
    (fg-heading-5 rainbow-5)
    (fg-heading-6 rainbow-6)
    (fg-heading-7 rainbow-7)
    (fg-heading-8 rainbow-8))
  "Common palette settings shared across themes.")

;;; --- Color generation ---

(defun mtg--generate-accent-variants (palette)
  "Generate warmer, cooler, and faint variants for accent colors in PALETTE."
  (let (result)
    (dolist (key mtg--accent-keys)
      (let ((color (mtg--plist-get palette key)))
        (when (mtg--hex-p color)
          (push (cons key color) result)
          (push (cons (intern (format "%s-warmer" key))
                      (mtg--warmer color))
                result)
          (push (cons (intern (format "%s-cooler" key))
                      (mtg--cooler color))
                result)
          (push (cons (intern (format "%s-faint" key))
                      (mtg--faint color))
                result))))
    (nreverse result)))

(defun mtg--generate-bg-variants (palette variant)
  "Generate background color variants from PALETTE.
VARIANT is either 'dark or 'light."
  (let* ((bg-main (mtg--plist-get palette 'bg-main))
         (bg-dim (or (mtg--plist-get palette 'bg-dim)
                     (if (eq variant 'dark)
                         (mtg--darken bg-main 5)
                       (mtg--darken bg-main 3))))
         (bg-alt (or (mtg--plist-get palette 'bg-alt)
                     bg-dim))
         (bg-active (or (mtg--plist-get palette 'bg-active)
                        (if (eq variant 'dark)
                            (mtg--lighten bg-main 12)
                          (mtg--darken bg-main 10))))
         (border (or (mtg--plist-get palette 'border)
                     (if (eq variant 'dark)
                         (mtg--lighten bg-main 15)
                       (mtg--darken bg-main 15))))
         (blue (mtg--plist-get palette 'blue)))
    `((bg-main . ,bg-main)
      (bg-dim . ,bg-dim)
      (bg-alt . ,bg-alt)
      (bg-active . ,bg-active)
      (bg-inactive . ,bg-main)
      (border . ,border)
      (cursor . ,(or (mtg--plist-get palette 'cursor) blue)))))

(defun mtg--generate-fg-colors (palette minimum-ratio)
  "Generate accessible foreground colors from PALETTE.
Ensure every result reaches MINIMUM-RATIO against `bg-main'."
  (let* ((background (mtg--plist-get palette 'bg-main))
         (fg-main (mtg--plist-get palette 'fg-main))
         (fg-dim (or (mtg--plist-get palette 'fg-dim)
                     (mtg--faint fg-main 20)))
         (fg-alt (or (mtg--plist-get palette 'fg-alt)
                     (mtg--desaturate fg-main 15))))
    `((fg-main . ,(mtg--ensure-contrast fg-main background minimum-ratio))
      (fg-dim . ,(mtg--ensure-contrast fg-dim background minimum-ratio))
      (fg-alt . ,(mtg--ensure-contrast fg-alt background minimum-ratio)))))

(defun mtg--generate-intense-colors (palette)
  "Generate intense background colors from PALETTE.
These are pastel versions for search highlights etc."
  (let ((red (mtg--plist-get palette 'red))
        (orange (mtg--plist-get palette 'orange))
        (green (mtg--plist-get palette 'green))
        (yellow (mtg--plist-get palette 'yellow))
        (blue (mtg--plist-get palette 'blue))
        (magenta (mtg--plist-get palette 'magenta))
        (cyan (mtg--plist-get palette 'cyan)))
    ;; Intense colors are bright, pastel versions
    `((bg-red-intense . ,(mtg--blend "#ffffff" red 0.5))
      ,@(when orange `((bg-orange-intense . ,(mtg--blend "#ffffff" orange 0.55))))
      (bg-green-intense . ,(mtg--blend "#ffffff" green 0.55))
      (bg-yellow-intense . ,(mtg--blend "#ffffff" yellow 0.6))
      (bg-blue-intense . ,(mtg--blend "#ffffff" blue 0.45))
      (bg-magenta-intense . ,(mtg--blend "#ffffff" magenta 0.5))
      (bg-cyan-intense . ,(mtg--blend "#ffffff" cyan 0.55)))))

(defun mtg--generate-subtle-colors (palette)
  "Generate subtle background colors from PALETTE.
These are very light, desaturated versions."
  (let ((red (mtg--plist-get palette 'red))
        (orange (mtg--plist-get palette 'orange))
        (green (mtg--plist-get palette 'green))
        (yellow (mtg--plist-get palette 'yellow))
        (blue (mtg--plist-get palette 'blue))
        (magenta (mtg--plist-get palette 'magenta))
        (cyan (mtg--plist-get palette 'cyan)))
    ;; Subtle colors are very light, low saturation
    `((bg-red-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate red 20) 0.25))
      ,@(when orange `((bg-orange-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate orange 20) 0.3))))
      (bg-green-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate green 20) 0.3))
      (bg-yellow-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate yellow 20) 0.35))
      (bg-blue-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate blue 20) 0.25))
      (bg-magenta-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate magenta 20) 0.3))
      (bg-cyan-subtle . ,(mtg--blend "#ffffff" (mtg--desaturate cyan 20) 0.3)))))

(defun mtg--generate-diff-colors (palette _variant)
  "Generate diff/git colors from PALETTE.

Backgrounds tint `bg-main' towards the theme accents (green for added,
red for removed, yellow for changed):
- bg-*-faint: 8% (unfocused hunks)
- bg-*: 15% (focused hunks)
- bg-*-refine: 30% (exact changes within a line)

Diff foregrounds are semantic mappings in `mtg--palette-common', not base
colors, so they can use `unspecified' to preserve syntax highlighting."
  (let ((bg-main (mtg--plist-get palette 'bg-main))
        (result nil))
    (dolist (spec '((added . green) (removed . red) (changed . yellow)))
      (let ((accent (mtg--plist-get palette (cdr spec)))
            (kind (car spec)))
        (dolist (level '(("-faint" . 0.08) ("" . 0.15) ("-refine" . 0.30)))
          (push (cons (intern (format "bg-%s%s" kind (car level)))
                      (mtg--blend bg-main accent (cdr level)))
                result))))
    (nreverse result)))

(defun mtg--generate-ui-colors (palette variant)
  "Generate UI colors (mode-line, completion, etc.) from PALETTE for VARIANT."
  (let* ((bg-main (mtg--plist-get palette 'bg-main))
         (fg-main (mtg--plist-get palette 'fg-main))
         (bg-dim (or (mtg--plist-get palette 'bg-dim)
                     (if (eq variant 'dark)
                         (mtg--darken bg-main 5)
                       (mtg--darken bg-main 3))))
         (blue (mtg--plist-get palette 'blue))
         (bg-active (if (eq variant 'dark)
                        (mtg--lighten bg-main 12)
                      (mtg--darken bg-main 10))))
    `((bg-mode-line-active . ,(or (mtg--plist-get palette 'bg-mode-line-active)
                                  (mtg--blend bg-main blue 0.25)))
      (fg-mode-line-active . ,fg-main)
      (bg-completion . ,bg-active)
      (bg-hover . ,bg-active)
      (bg-hover-secondary . ,bg-active)
      (bg-hl-line . ,bg-dim))))

(defun mtg--generate-teal (palette)
  "Generate teal color from PALETTE if not provided."
  (let ((cyan (mtg--plist-get palette 'cyan))
        (green (mtg--plist-get palette 'green)))
    `((teal . ,(or (mtg--plist-get palette 'teal)
                   ;; Teal is between cyan and green, shift cyan towards green.
                   (mtg--blend cyan green 0.35))))))

;;; --- Syntax mapping ---

(defun mtg--merge-syntax-mapping (user-syntax)
  "Merge USER-SYNTAX plist with defaults, USER-SYNTAX takes precedence."
  (let ((result (copy-sequence mtg--default-syntax-mapping)))
    (when user-syntax
      (let ((keys (mtg--plist-keys user-syntax)))
        (dolist (key keys)
          (setq result (plist-put result key (plist-get user-syntax key))))))
    result))

(defun mtg--plist->alist (plist)
  "Convert PLIST to alist."
  (let (result)
    (while plist
      (push (cons (pop plist) (pop plist)) result))
    (nreverse result)))

;;; --- Rendering ---

(defun mtg--render-header (name description)
  "Render file header for theme NAME with DESCRIPTION."
  (format ";;; modern-%s-theme.el --- %s -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation, Inc.

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; The `modern-%s' theme is a port based on modus-themes structure.

;;; Code:

" name description name))

(defun mtg--alist->sexp-string (alist)
  "Convert ALIST to formatted sexp string for defconst."
  (mapconcat
   (lambda (pair)
     (format "    (%s %S)" (car pair) (cdr pair)))
   alist
   "\n"))

(defun mtg--render-palette-partial (name alist)
  "Render palette-partial defconst for NAME from ALIST."
  (format "(defconst modern-%s-palette-partial
  '((cursor %S)
%s))

" name
(cdr (assq 'cursor alist))
(mtg--alist->sexp-string
 (seq-filter (lambda (p) (not (eq (car p) 'cursor))) alist))))

(defun mtg--render-palette-common (name)
  "Render palette-common defconst for NAME."
  (format "(defconst modern-%s-palette-common
  '(%s))

" name
(mapconcat
 (lambda (pair)
   (format "(%s %s)" (car pair) (cadr pair)))
 mtg--palette-common
 "\n    ")))

(defun mtg--render-mappings-partial (name syntax-plist variant)
  "Render palette mappings for NAME, SYNTAX-PLIST, and VARIANT."
  (let* ((merged (mtg--merge-syntax-mapping syntax-plist))
         (alist (mtg--plist->alist merged))
         (term-black (if (eq variant 'dark) 'fg-dim 'fg-main)))
    (format "(defconst modern-%s-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (fg-link blue)
    (fg-link-visited magenta)
    (name red)
    (keybind red)
    (identifier red)
    (fg-prompt magenta)

    ;; Keep ANSI neutral foregrounds readable in terminal packages such as
    ;; Ghostel while leaving their background mappings to modus-themes.
    (fg-term-black %s)
    (fg-term-black-bright fg-dim)
    (fg-term-white fg-dim)
    (fg-term-white-bright fg-main)

%s
    (variable-use red)

    (accent-0 magenta)
    (accent-1 yellow)
    (accent-2 blue)
    (accent-3 red)

    (date-common cyan)
    (date-deadline red)
    (date-deadline-subtle red-faint)
    (date-event fg-alt)
    (date-holiday magenta)
    (date-now fg-main)
    (date-range fg-alt)
    (date-scheduled yellow)
    (date-scheduled-subtle yellow-faint)
    (date-weekday cyan)
    (date-weekend red-faint)

    (fg-prose-code yellow)
    (prose-done green)
    (fg-prose-macro cyan)
    (prose-metadata fg-dim)
    (prose-metadata-value fg-alt)
    (prose-table fg-alt)
    (prose-table-formula info)
    (prose-tag yellow-faint)
    (prose-todo red)
    (fg-prose-verbatim magenta)

    (mail-cite-0 yellow)
    (mail-cite-1 magenta)
    (mail-cite-2 blue)
    (mail-cite-3 cyan)
    (mail-part magenta-faint)
    (mail-recipient magenta)
    (mail-subject magenta)
    (mail-other magenta)

    (bg-search-static bg-warning)
    (bg-search-current bg-yellow-intense)
    (bg-search-lazy bg-hover)
    (bg-search-replace bg-red-intense)

    (bg-search-rx-group-0 bg-magenta-intense)
    (bg-search-rx-group-1 bg-green-intense)
    (bg-search-rx-group-2 bg-red-subtle)
    (bg-search-rx-group-3 bg-cyan-subtle)

    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)

    (rainbow-0 magenta)
    (rainbow-1 magenta)
    (rainbow-2 yellow)
    (rainbow-3 cyan)
    (rainbow-4 magenta)
    (rainbow-5 blue)
    (rainbow-6 red)
    (rainbow-7 cyan)
    (rainbow-8 yellow)))

" name term-black
(mapconcat
 (lambda (pair)
   (format "    (%s %s)" (car pair) (cdr pair)))
 alist
 "\n"))))

(defun mtg--render-palette-overrides (name)
  "Render palette-overrides defcustom for NAME."
  (format "(defcustom modern-%s-palette-overrides nil
  \"Overrides for `modern-%s-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details).\"
  :group 'modern-%s
  :type '(repeat (list symbol (choice symbol string))))

" name name name))

(defun mtg--render-palette (name)
  "Render main palette defconst for NAME."
  (format "(defconst modern-%s-palette
  (modus-themes-generate-palette
   modern-%s-palette-partial
   nil
   nil
   (append modern-%s-palette-mappings-partial modern-%s-palette-common)))

" name name name name))

(defun mtg--render-custom-faces (name)
  "Render custom-faces defconst for NAME."
  (format "(defconst modern-%s-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

" name))

(defun mtg--render-theme-call (name description variant)
  "Render modus-themes-theme macro call for NAME, DESCRIPTION, VARIANT."
  (format "(modus-themes-theme
 'modern-%s
 'modern-%s
 \"%s\"
 '%s
 'modern-%s-palette
 nil
 'modern-%s-palette-overrides
 'modern-%s-custom-faces)

" name name description variant name name name))

(defun mtg--render-provide (name)
  "Render provide form for NAME."
  (format "(provide 'modern-%s-theme)
;;; modern-%s-theme.el ends here
" name name))

;;; --- Main entry point ---

;;;###autoload
(defun modern-generate-theme (&rest args)
  "Generate a complete Emacs theme and copy to clipboard.

ARGS is a plist with:
  :name        - Theme name (required, e.g. \"tokyo\")
  :variant     - 'dark or 'light (default: 'dark)
  :description - Theme description string
  :palette     - Plist of colors (required):
                   bg-main, fg-main, red, green, yellow, blue, magenta, cyan
                 Optional: bg-dim, bg-alt, fg-dim, fg-alt, cursor, border, teal
                 Values can be hex colors or expressions:
                   (darken bg-main 10)
                   (lighten red 20)
                   (blend bg-main blue 0.3)
                   (warmer green 5)
                   (cooler magenta)
                   (faint yellow 30)
  :syntax      - Optional plist to override syntax colors, e.g.:
                   '(fnname red keyword cyan)
  :minimum-contrast - Optional WCAG ratio for foreground colors (default: 4.5)
  :path        - Optional directory path to save the theme file.
                 If provided, saves to PATH/modern-NAME-theme.el

Returns the generated theme string (also copied to clipboard)."
  (let* ((name (plist-get args :name))
         (variant (or (plist-get args :variant) 'dark))
         (description (or (plist-get args :description)
                          (format "Modern %s theme port." name)))
         (raw-palette (plist-get args :palette))
         (syntax (plist-get args :syntax))
         (path (plist-get args :path))
         (minimum-contrast
          (or (plist-get args :minimum-contrast)
              modern-theme-generator-minimum-contrast))
         ;; Resolve color expressions to hex values.
         (palette (mtg--resolve-palette raw-palette)))

    ;; Validate required parameters
    (unless name
      (error "Missing required :name parameter"))
    (unless raw-palette
      (error "Missing required :palette parameter"))

    ;; Validate required palette colors (after resolution).
    (dolist (key '(bg-main fg-main red green yellow blue magenta cyan))
      (unless (mtg--hex-p (mtg--plist-get palette key))
        (error "Missing or invalid required palette color: %s" key)))
    (unless (and (numberp minimum-contrast)
                 (<= 1.0 minimum-contrast 21.0))
      (error ":minimum-contrast must be a number from 1.0 to 21.0"))

    ;; Normalize colors used as text before deriving the complete palette.
    (setq palette
          (mtg--normalize-foreground-palette palette minimum-contrast))

    ;; Generate all color components.
    (let* ((bg-colors (mtg--generate-bg-variants palette variant))
           (fg-colors (mtg--generate-fg-colors palette minimum-contrast))
           (accents (mtg--generate-accent-variants palette))
           (intense (mtg--generate-intense-colors palette))
           (subtle (mtg--generate-subtle-colors palette))
           (diff (mtg--generate-diff-colors palette variant))
           (ui (mtg--generate-ui-colors palette variant))
           (teal (mtg--generate-teal palette))
           ;; Merge all color alists
           (all-colors (append bg-colors fg-colors accents intense subtle diff ui teal))
           ;; Sort by symbol name for consistent output
           (sorted-colors (sort (copy-sequence all-colors)
                                (lambda (a b)
                                  (string< (symbol-name (car a))
                                           (symbol-name (car b)))))))

      ;; Build complete theme file
      (let ((output (concat
                     (mtg--render-header name description)
                     "(require 'modus-themes)\n\n"
                     (mtg--render-palette-partial name sorted-colors)
                     (mtg--render-palette-common name)
                     (mtg--render-mappings-partial name syntax variant)
                     (mtg--render-palette-overrides name)
                     (mtg--render-palette name)
                     (mtg--render-custom-faces name)
                     (mtg--render-theme-call name description variant)
                     (mtg--render-provide name))))
        ;; Copy to clipboard
        (kill-new output)
        (when (fboundp 'gui-set-selection)
          (gui-set-selection 'CLIPBOARD output))
        ;; Save to file if path is provided
        (when path
          (let* ((dir (file-name-as-directory (expand-file-name path)))
                 (filename (format "modern-%s-theme.el" name))
                 (filepath (concat dir filename)))
            (unless (file-directory-p dir)
              (make-directory dir t))
            (with-temp-file filepath
              (insert output))
            (message "Theme 'modern-%s' saved to %s" name filepath)))
        (unless path
          (message "Theme 'modern-%s' generated and copied to clipboard!" name))
        output))))

(provide 'theme-generator)
;;; theme-generator.el ends here
