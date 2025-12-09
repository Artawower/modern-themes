;;; modern-nano-light-theme.el --- Modern Nano Light theme port -*- lexical-binding:t -*-

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
;; The `modern-nano-light' theme is a port of the Nano Light theme
;; to the `modus-themes' structure.
;; It follows the N Λ N O aesthetic: roughly monochrome with few accents.

;;; Code:

(require 'modus-themes)

(defconst modern-nano-light-palette-partial
  '((cursor "#37474F")
    (bg-main "#FFFFFF")
    (bg-dim "#FAFAFA")
    (bg-alt "#FAFAFA")
    (fg-main "#37474F")
    (fg-dim "#90A4AE")
    (fg-alt "#90A4AE")
    (bg-active "#ECEFF1")
    (bg-inactive "#FFFFFF")
    (border "#ECEFF1")

    ;; Nano Palette
    ;; Salient: #673AB7 (Purple)
    ;; Popout:  #FFAB91 (Salmon/Orange)
    ;; Critical: #FF6F00 (Amber)
    ;; Strong:   #263238 (Dark Grey)

    (red "#EF5350")
    (red-warmer "#FF6F00")
    (red-cooler "#EF5350")
    (red-faint "#FFCDD2")
    (green "#66BB6A")
    (green-warmer "#66BB6A")
    (green-cooler "#66BB6A")
    (green-faint "#C8E6C9")
    (yellow "#E2C12F")
    (yellow-warmer "#FFAB91")
    (yellow-cooler "#E2C12F")
    (yellow-faint "#FFF9C4")
    (blue "#90A4AE")
    (blue-warmer "#42A5F5")
    (blue-cooler "#90A4AE")
    (blue-faint "#BBDEFB")
    (magenta "#673AB7")
    (magenta-warmer "#AB47BC")
    (magenta-cooler "#673AB7")
    (magenta-faint "#E1BEE7")
    (cyan "#90A4AE")
    (cyan-warmer "#26C6DA")
    (cyan-cooler "#005478")
    (cyan-faint "#B2EBF2")
    (teal "#90A4AE")

    (bg-red-intense "#FFCDD2")
    (bg-green-intense "#C8E6C9")
    (bg-yellow-intense "#FFF9C4")
    (bg-blue-intense "#BBDEFB")
    (bg-magenta-intense "#E1BEE7")
    (bg-cyan-intense "#B2EBF2")

    (bg-red-subtle "#FAFAFA")
    (bg-green-subtle "#FAFAFA")
    (bg-yellow-subtle "#FAFAFA")
    (bg-blue-subtle "#FAFAFA")
    (bg-magenta-subtle "#FAFAFA")
    (bg-cyan-subtle "#FAFAFA")

    (bg-added "#C8E6C9")
    (bg-added-faint "#E8F5E9")
    (bg-added-refine "#A5D6A7")
    (fg-added "#1B5E20")

    (bg-changed "#FFF9C4")
    (bg-changed-faint "#FFFDE7")
    (bg-changed-refine "#FFF59D")
    (fg-changed "#F57F17")

    (bg-removed "#FFCDD2")
    (bg-removed-faint "#FFEBEE")
    (bg-removed-refine "#EF9A9A")
    (fg-removed "#B71C1C")

    (fg-strong "#263238")))

(defconst modern-nano-light-palette-common
  '((fringe unspecified)
    (fg-region unspecified)

    (bg-diff-context bg-dim)

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

    (fg-search-current fg-main)
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
    (fg-heading-8 rainbow-8)))

(defconst modern-nano-light-palette-mappings-partial
  '((err red-warmer)
    (warning yellow-warmer)
    (warning yellow-warmer)
    (info magenta)

    (bg-mode-line-active bg-dim)
    (fg-mode-line-active fg-strong)

    (bg-completion bg-dim)
    (bg-hover bg-active)
    (bg-hover-secondary bg-active)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-active)

    (fg-link magenta)
    (fg-link-visited magenta-warmer)
    (name fg-main)
    (keybind magenta)
    (identifier fg-main)
    (fg-prompt magenta)

    (builtin magenta)
    (comment fg-dim)
    (constant fg-main)
    (fnname fg-main)
    (fnname-call fg-main)
    (keyword magenta)
    (preprocessor magenta)
    (docstring fg-dim)
    (string fg-dim)
    (type magenta)
    (variable fg-main)
    (property fg-main)
    (variable-use fg-main)
    (rx-backslash magenta)
    (rx-construct magenta)

    (accent-0 fg-main)
    (accent-1 fg-main)
    (accent-2 fg-main)
    (accent-3 fg-main)

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

    (fg-prose-code fg-dim)
    (prose-done green)
    (fg-prose-macro magenta)
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
    (bg-search-lazy bg-blue-intense)
    (bg-search-replace bg-red-intense)

    (bg-search-rx-group-0 bg-magenta-intense)
    (bg-search-rx-group-1 bg-green-intense)
    (bg-search-rx-group-2 bg-red-subtle)
    (bg-search-rx-group-3 bg-cyan-subtle)

    (rainbow-0 fg-main)
    (rainbow-1 fg-main)
    (rainbow-2 fg-main)
    (rainbow-3 fg-main)
    (rainbow-4 fg-main)
    (rainbow-5 fg-main)
    (rainbow-6 fg-main)
    (rainbow-7 fg-main)
    (rainbow-8 fg-main)))

(defcustom modern-nano-light-palette-overrides nil
  "Overrides for `modern-nano-light-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-nano-light
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-nano-light-palette
  (modus-themes-generate-palette
   modern-nano-light-palette-partial
   nil
   nil
   (append modern-nano-light-palette-mappings-partial modern-nano-light-palette-common)))

(defconst modern-nano-light-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-nano-light
 'modern-nano-light
 "Modern Nano Light theme port."
 'light
 'modern-nano-light-palette
 nil
 'modern-nano-light-palette-overrides
 'modern-nano-light-custom-faces)

(provide 'modern-nano-light-theme)
;;; modern-nano-light-theme.el ends here
