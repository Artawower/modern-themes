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

    (bg-diff-context bg-dim)
    (bg-diff-focus bg-dim)
    (bg-diff-text bg-active)

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
          ;; Base color
          (push (cons key color) result)
          ;; Warmer variant
          (push (cons (intern (format "%s-warmer" key))
                      (mtg--warmer color))
                result)
          ;; Cooler variant
          (push (cons (intern (format "%s-cooler" key))
                      (mtg--cooler color))
                result)
          ;; Faint variant
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

(defun mtg--generate-fg-colors (palette)
  "Generate foreground colors from PALETTE."
  `((fg-main . ,(mtg--plist-get palette 'fg-main))
    (fg-dim . ,(or (mtg--plist-get palette 'fg-dim)
                   (mtg--faint (mtg--plist-get palette 'fg-main) 20)))
    (fg-alt . ,(or (mtg--plist-get palette 'fg-alt)
                   (mtg--desaturate (mtg--plist-get palette 'fg-main) 15)))))

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

(defun mtg--make-diff-refine-bg (color variant)
  "Create a diff refine background from COLOR for VARIANT.
Results in a muted, darker version - subtle highlight that doesn't overpower text."
  (let* ((rgb (mtg--rgb color))
         (hsl (apply #'color-rgb-to-hsl rgb))
         (h (nth 0 hsl))
         ;; Target: S=15%, L=22-24% for dark themes (very subtle tint)
         ;;         S=30%, L=75% for light themes (more visible)
         (target-s (if (eq variant 'dark) 0.15 0.30))
         (target-l (if (eq variant 'dark) 0.23 0.75)))
    (mtg--hex (color-hsl-to-rgb h target-s target-l))))

(defun mtg--generate-diff-colors (palette variant)
  "Generate diff/git colors from PALETTE for VARIANT (dark/light).

- bg-added/changed/removed: bg-dim (fills space, no holes)
- bg-*-faint: bg-dim
- bg-*-refine: muted accent color (highlights exact changes)
- fg-*: bright accent color (green/yellow/red)"
  (let* ((bg-main (mtg--plist-get palette 'bg-main))
         (bg-dim (or (mtg--plist-get palette 'bg-dim)
                     (if (eq variant 'dark)
                         (mtg--darken bg-main 5)
                       (mtg--lighten bg-main 3))))
         (green (mtg--plist-get palette 'green))
         (red (mtg--plist-get palette 'red))
         (yellow (mtg--plist-get palette 'yellow))
         ;; Refine backgrounds - muted accent colors for highlighting exact changes
         (bg-added-ref (mtg--make-diff-refine-bg green variant))
         (bg-removed-ref (mtg--make-diff-refine-bg red variant))
         (bg-changed-ref (mtg--make-diff-refine-bg yellow variant)))
    `((bg-added . ,bg-dim)
      (bg-added-faint . ,bg-dim)
      (bg-added-refine . ,bg-added-ref)
      (fg-added . ,green)
      (bg-removed . ,bg-dim)
      (bg-removed-faint . ,bg-dim)
      (bg-removed-refine . ,bg-removed-ref)
      (fg-removed . ,red)
      (bg-changed . ,bg-dim)
      (bg-changed-faint . ,bg-dim)
      (bg-changed-refine . ,bg-changed-ref)
      (fg-changed . ,yellow))))

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
                   ;; Teal is between cyan and green, shift cyan towards green
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

(defun mtg--render-mappings-partial (name syntax-plist)
  "Render palette-mappings-partial for NAME with SYNTAX-PLIST."
  (let* ((merged (mtg--merge-syntax-mapping syntax-plist))
         (alist (mtg--plist->alist merged)))
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

" name
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
         ;; Resolve color expressions to hex values
         (palette (mtg--resolve-palette raw-palette)))

    ;; Validate required parameters
    (unless name
      (error "Missing required :name parameter"))
    (unless raw-palette
      (error "Missing required :palette parameter"))

    ;; Validate required palette colors (after resolution)
    (dolist (key '(bg-main fg-main red green yellow blue magenta cyan))
      (unless (mtg--hex-p (mtg--plist-get palette key))
        (error "Missing or invalid required palette color: %s" key)))

    ;; Generate all color components
    (let* ((bg-colors (mtg--generate-bg-variants palette variant))
           (fg-colors (mtg--generate-fg-colors palette))
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
                     (mtg--render-mappings-partial name syntax)
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
