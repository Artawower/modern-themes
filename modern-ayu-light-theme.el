;;; modern-ayu-light-theme.el --- Ayu Light theme port -*- lexical-binding:t -*-

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
;; The `modern-ayu-light' theme is a port of the Ayu Light theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-ayu-light-palette-partial
  '((cursor "#FFAA33")
    (bg-main "#FCFCFC")
    (bg-dim "#F8F9FA")
    (bg-alt "#F3F4F5")
    (fg-main "#5C6166")
    (fg-dim "#8A9199")
    (fg-alt "#FA8D3E")
    (bg-active "#F3F4F5")
    (bg-inactive "#F8F9FA")
    (border "#E0E5E9")

    (red           "#E65050")
    (red-warmer    "#F06060")
    (red-cooler    "#D64040")
    (red-faint     "#C63030")
    
    (green         "#6CBF43")
    (green-warmer  "#7CCF53")
    (green-cooler  "#5CAF33")
    (green-faint   "#4C9F23")
    
    (yellow        "#FFAA33")
    (yellow-warmer "#FFBA43")
    (yellow-cooler "#FF9A23")
    (yellow-faint  "#E68A13")
    
    (blue          "#399EE6")
    (blue-warmer   "#49AEF6")
    (blue-cooler   "#2990D6")
    (blue-faint    "#1982C6")
    
    (magenta        "#A37ACC")
    (magenta-warmer "#B38ADC")
    (magenta-cooler "#937ABC")
    (magenta-faint  "#836AAC")

    (cyan        "#55B4D4")
    (cyan-warmer "#65C4E4")
    (cyan-cooler "#45A4C4")
    (cyan-faint  "#3594B4")
    (teal        "#4CBF99")

    (bg-red-intense     "#FFEBEE")
    (bg-green-intense   "#E8F5E8")
    (bg-yellow-intense  "#FFF8E1")
    (bg-blue-intense    "#E3F2FD")
    (bg-magenta-intense "#F3E5F5")
    (bg-cyan-intense    "#E0F2F1")

    (bg-red-subtle     "#FFCDD2")
    (bg-green-subtle   "#C8E6C9")
    (bg-yellow-subtle  "#FFF9C4")
    (bg-blue-subtle    "#BBDEFB")
    (bg-magenta-subtle "#E1BEE7")
    (bg-cyan-subtle    "#B2DFDB")

    
    (bg-added         "#E8F5E8")
    (bg-added-faint   "#F1F8E9")
    (bg-added-refine  "#C8E6C9")
    (fg-added         "#2E7D32")

    (bg-changed        "#E3F2FD")
    (bg-changed-faint  "#E8F4FD")
    (bg-changed-refine "#BBDEFB")
    (fg-changed        "#1565C0")

    (bg-removed        "#FFEBEE")
    (bg-removed-faint  "#FFCDD2")
    (bg-removed-refine "#EF5350")
    (fg-removed        "#C62828")

    
    (bg-mode-line-active-col "#F3F4F5")
    (bg-hover                "#F8F9FA")
    (bg-hover-secondary-col  "#F3F4F5")
    (fg-heading-0-col "#E65050")
    (fg-heading-1-col "#FFAA33")
    (fg-heading-2-col "#FA8D3E")
    (fg-heading-3-col "#6CBF43")
    (fg-heading-4-col "#55B4D4")
    (fg-heading-5-col "#399EE6")
    (fg-heading-6-col "#49AEF6")
    (fg-heading-7-col "#A37ACC")
    (fg-heading-8-col "#B38ADC")))

(defconst modern-ayu-light-palette-common
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

(defconst modern-ayu-light-palette-mappings-partial
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

(defcustom modern-ayu-light-palette-overrides nil
  "Overrides for `modern-ayu-light-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-ayu-light
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-ayu-light-palette
  (modus-themes-generate-palette
   modern-ayu-light-palette-partial
   nil
   nil
   (append modern-ayu-light-palette-mappings-partial
           modern-ayu-light-palette-common)))

(defconst modern-ayu-light-custom-faces
  '(`(magit-section-highlight
      ((,c :background ,bg-main)))
    `(magit-diff-file-heading-highlight
      ((,c :inherit magit-diff-file-heading :background ,bg-main)))))

(modus-themes-theme
 'modern-ayu-light
 'modern-ayu-light
 "Ayu Light theme port."
 'light
 'modern-ayu-light-palette
 nil
 'modern-ayu-light-palette-overrides
 'modern-ayu-light-custom-faces)

(provide 'modern-ayu-light-theme)
;;; modern-ayu-light-theme.el ends here