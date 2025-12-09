;;; modern-catppuccin-latte-theme.el --- Catppuccin Latte theme port -*- lexical-binding:t -*-

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
;; The `modern-catppuccin-latte' theme is a port of the Catppuccin Latte theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-catppuccin-latte-palette-partial
  '((cursor "#dc8a78")
    (bg-main "#eff1f5")
    (bg-dim "#dce0e8")
    (bg-alt "#ccd0da")
    (fg-main "#4c4f69")
    (fg-dim "#9ca0b0")
    (fg-alt "#5c5f77")
    (bg-active "#BCC0CC")
    (bg-inactive "#e6e9ef")
    (border "#9ca0b0")

    (red           "#d20f39")
    (red-warmer    "#e64553")
    (red-cooler    "#dd7878")
    (red-faint     "#dc8a78")
    
    (green         "#40a02b")
    (green-warmer  "#5cb53f")
    (green-cooler  "#179299")
    (green-faint   "#8ecf7d")
    
    (yellow        "#df8e1d")
    (yellow-warmer "#fe640b")
    (yellow-cooler "#e5c890")
    (yellow-faint  "#f5e0c3")
    
    (blue          "#1e66f5")
    (blue-warmer   "#6c71f9")
    (blue-cooler   "#7287fd")
    (blue-faint    "#b0c4ff")
    
    (magenta        "#8839ef")
    (magenta-warmer "#ea76cb")
    (magenta-cooler "#7287fd")
    (magenta-faint  "#c6a0f6")

    (cyan        "#04a5e5")
    (cyan-warmer "#209fb5")
    (cyan-cooler "#179299")
    (cyan-faint  "#9cd6f4")
    (teal        "#179299")

    (bg-red-intense     "#e4a1b3")
    (bg-green-intense   "#b1d4ae")
    (bg-yellow-intense  "#e9cea9")
    (bg-blue-intense    "#a5c0f5")
    (bg-magenta-intense "#cab0f2")
    (bg-cyan-intense    "#9cd6ef")

    (bg-red-subtle     "#eacfd8")
    (bg-green-subtle   "#d4e4d6")
    (bg-yellow-subtle  "#ece2d4")
    (bg-blue-subtle    "#cfdcf5")
    (bg-magenta-subtle "#dfd5f4")
    (bg-cyan-subtle    "#cbe5f2")

    
    (bg-added         "#e3f2da")
    (bg-added-faint   "#eef7e6")
    (bg-added-refine  "#a6d189")
    (fg-added         "#326925")

    (bg-changed        "#f5e0c3")
    (bg-changed-faint  "#f9ecda")
    (bg-changed-refine "#e5c890")
    (fg-changed        "#7a4f1c")

    (bg-removed        "#f4d8dd")
    (bg-removed-faint  "#fae8ea")
    (bg-removed-refine "#e78284")
    (fg-removed        "#7a2932")

    
    (bg-mode-line-active-col "#bcc0cc")
    (bg-hover                "#ccd0da")
    (bg-hover-secondary-col  "#bcc0cc")
    (fg-heading-0-col "#d20f39")
    (fg-heading-1-col "#fe640b")
    (fg-heading-2-col "#df8e1d")
    (fg-heading-3-col "#40a02b")
    (fg-heading-4-col "#209fb5")
    (fg-heading-5-col "#1e66f5")
    (fg-heading-6-col "#7287fd")
    (fg-heading-7-col "#8839ef")
    (fg-heading-8-col "#ea76cb")))

(defconst modern-catppuccin-latte-palette-common
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

(defconst modern-catppuccin-latte-palette-mappings-partial
  '((err red-warmer)
    (warning fg-main)
    (info blue-warmer)

    (bg-mode-line-active bg-mode-line-active-col)
    (fg-mode-line-active fg-main)

    (bg-completion bg-alt)
    (bg-hover-secondary bg-hover-secondary-col)
    (bg-hl-line bg-dim)
    (fg-paren-match yellow-warmer)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-active)

    (fg-link blue)
    (fg-link-visited blue-cooler)
    (name magenta)
    (keybind red)
    (identifier magenta-warmer)
    (fg-prompt magenta)

    (builtin red)
    (comment fg-dim)
    (constant yellow-warmer)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta)
    (preprocessor red-faint)
    (docstring fg-dim)
    (string green)
    (type yellow)
    (variable fg-main)
    (property fg-main)
    (variable-use fg-main)
    (rx-backslash cyan-warmer)
    (rx-construct yellow-warmer)

    (accent-0 magenta)
    (accent-1 yellow)
    (accent-2 blue)
    (accent-3 red)

    (date-common cyan-warmer)
    (date-deadline red)
    (date-deadline-subtle red-faint)
    (date-event fg-alt)
    (date-holiday red-cooler)
    (date-now fg-main)
    (date-range fg-alt)
    (date-scheduled yellow)
    (date-scheduled-subtle yellow)
    (date-weekday cyan-warmer)
    (date-weekend red-faint)

    (fg-prose-code yellow)
    (prose-done green)
    (fg-prose-macro magenta)
    (prose-metadata fg-dim)
    (prose-metadata-value fg-alt)
    (prose-table fg-alt)
    (prose-table-formula info)
    (prose-tag yellow-warmer)
    (prose-todo red)
    (fg-prose-verbatim magenta)

    (mail-cite-0 yellow)
    (mail-cite-1 magenta)
    (mail-cite-2 blue)
    (mail-cite-3 cyan-warmer)
    (mail-part magenta-warmer)
    (mail-recipient magenta)
    (mail-subject fg-main)
    (mail-other magenta)

    (bg-search-static bg-warning)
    (bg-search-current yellow)
    (bg-search-lazy blue-cooler)
    (fg-search-lazy bg-main)
    (bg-search-replace red)
    (fg-search-replace bg-main)

    (bg-search-rx-group-0 magenta)
    (bg-search-rx-group-1 green)
    (bg-search-rx-group-2 red)
    (bg-search-rx-group-3 cyan-warmer)

    (rainbow-0 fg-heading-0-col)
    (rainbow-1 fg-heading-1-col)
    (rainbow-2 fg-heading-2-col)
    (rainbow-3 fg-heading-3-col)
    (rainbow-4 fg-heading-4-col)
    (rainbow-5 fg-heading-5-col)
    (rainbow-6 fg-heading-6-col)
    (rainbow-7 fg-heading-7-col)
    (rainbow-8 fg-heading-8-col)))

(defcustom modern-catppuccin-latte-palette-overrides nil
  "Overrides for `modern-catppuccin-latte-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-catppuccin-latte
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-catppuccin-latte-palette
  (modus-themes-generate-palette
   modern-catppuccin-latte-palette-partial
   nil
   nil
   (append modern-catppuccin-latte-palette-mappings-partial
           modern-catppuccin-latte-palette-common)))

(defconst modern-catppuccin-latte-custom-faces
  '(`(magit-section-highlight
      ((,c :background ,bg-main)))
    `(magit-diff-file-heading-highlight
      ((,c :inherit magit-diff-file-heading :background ,bg-main)))))

(modus-themes-theme
 'modern-catppuccin-latte
 'modern-catppuccin-latte
 "Catppuccin Latte theme port."
 'light
 'modern-catppuccin-latte-palette
 nil
 'modern-catppuccin-latte-palette-overrides
 'modern-catppuccin-latte-custom-faces)

(provide 'modern-catppuccin-latte-theme)
;;; modern-catppuccin-latte-theme.el ends here
