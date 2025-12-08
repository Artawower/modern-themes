;;; modern-deep-atom-theme.el --- Deep Atom theme port -*- lexical-binding:t -*-

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
;; The `modern-deep-atom' theme is a port of the Deep Atom theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-deep-atom-palette-partial
  '((cursor "#41a7fc")
    (bg-main "#1a212e")
    (bg-dim "#141b24")
    (bg-alt "#141b24")
    (fg-main "#a5b0c5")
    (fg-dim "#5B6268")
    (fg-alt "#5B6268")
    (bg-active "#3f444a")
    (bg-inactive "#1a212e")
    (border "#3f444a")

    (red           "#f65866")
    (red-warmer    "#ff6f7a")
    (red-cooler    "#e84d7c")
    (red-faint     "#c56a78")

    (green         "#8bcd5b")
    (green-warmer  "#9bd36a")
    (green-cooler  "#7ecb86")
    (green-faint   "#6ea975")

    (yellow        "#ECBE7B")
    (yellow-warmer "#f4b067")
    (yellow-cooler "#d9b982")
    (yellow-faint  "#b49063")

    (blue          "#41a7fc")
    (blue-warmer   "#5bbff8")
    (blue-cooler   "#2b82d4")
    (blue-faint    "#3f6ea6")

    (magenta       "#c75ae8")
    (magenta-warmer "#d873f1")
    (magenta-cooler "#b054e0")
    (magenta-faint  "#a36db9")

    (cyan          "#34bfd0")
    (cyan-warmer   "#4fd5ce")
    (cyan-cooler   "#2b94b0")
    (cyan-faint    "#5699AF")

    (bg-red-intense "#ff7f88")
    (bg-green-intense "#86df80")
    (bg-yellow-intense "#ffc200")
    (bg-blue-intense "#cbcfff")
    (bg-magenta-intense "#df8fff")
    (bg-cyan-intense "#88ccff")

    (bg-red-subtle "#fbc3cf")
    (bg-green-subtle "#b9edca")
    (bg-yellow-subtle "#f7e78f")
    (bg-blue-subtle "#ccdfff")
    (bg-magenta-subtle "#facdf5")
    (bg-cyan-subtle "#c2ecf0")

    (bg-added         "#3f444a")
    (bg-added-faint   "#141b24")
    (bg-added-refine  "#4b6a3a")
    (fg-added         "#8bcd5b")

    (bg-changed        "#3f444a")
    (bg-changed-faint  "#141b24")
    (bg-changed-refine "#7a6330")
    (fg-changed        "#ECBE7B")

    (bg-removed        "#3f444a")
    (bg-removed-faint  "#141b24")
    (bg-removed-refine "#7a3945")
    (fg-removed        "#f65866")))

(defconst modern-deep-atom-palette-common
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


    (fg-heading-0 rainbow-0)
    (fg-heading-1 rainbow-1)
    (fg-heading-2 rainbow-2)
    (fg-heading-3 rainbow-3)
    (fg-heading-4 rainbow-4)
    (fg-heading-5 rainbow-5)
    (fg-heading-6 rainbow-6)
    (fg-heading-7 rainbow-7)
    (fg-heading-8 rainbow-8)))

(defconst modern-deep-atom-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active blue-cooler)
    (fg-mode-line-active fg-main)

    (bg-hover bg-active)
    (bg-completion bg-active)
    (bg-hover-secondary bg-active)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-active)
    (bg-err red)
    (bg-warning yellow)
    (bg-info blue)
    (bg-region bg-active)

    (fg-link blue)
    (fg-link-visited magenta)
    (name red)
    (keybind red)
    (identifier red)
    (fg-prompt magenta)

    (builtin blue)
    (comment fg-dim)
    (constant red)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta)
    (preprocessor blue)
    (docstring fg-dim)
    (string green)
    (type yellow)
    (variable red)
    (variable-use red)
    (rx-backslash cyan)
    (rx-construct red)

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

    (bg-search-current yellow)
    (fg-search-current bg-main)
    (bg-search-lazy    blue)
    (fg-search-lazy bg-main)
    (bg-search-replace red)
    (fg-search-replace bg-main)
    (bg-search-static  bg-active)

    (bg-search-rx-group-0 magenta)
    (bg-search-rx-group-1 green)
    (bg-search-rx-group-2 red)
    (bg-search-rx-group-3 cyan)

    (fg-search-current fg-main)
    (fg-search-lazy    fg-main)
    (fg-search-replace fg-main)
    (fg-search-static  fg-main)


    (mail-cite-0 yellow)
    (mail-cite-1 magenta)
    (mail-cite-2 blue)
    (mail-cite-3 cyan)
    (mail-part magenta-faint)
    (mail-recipient magenta)
    (mail-subject magenta)
    (mail-other magenta)

    (bg-search-rx-group-0 bg-magenta-intense)
    (bg-search-rx-group-1 bg-green-intense)
    (bg-search-rx-group-2 bg-red-subtle)
    (bg-search-rx-group-3 bg-cyan-subtle)

    (rainbow-0 magenta)
    (rainbow-1 magenta)
    (rainbow-2 yellow)
    (rainbow-3 cyan)
    (rainbow-4 magenta)
    (rainbow-5 blue)
    (rainbow-6 red)
    (rainbow-7 cyan)
    (rainbow-8 yellow)))

(defcustom modern-deep-atom-palette-overrides nil
  "Overrides for `modern-deep-atom-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-deep-atom
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-deep-atom-palette
  (modus-themes-generate-palette
   modern-deep-atom-palette-partial
   nil
   nil
   (append modern-deep-atom-palette-mappings-partial modern-deep-atom-palette-common)))

(defconst modern-deep-atom-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-deep-atom
 'modern-deep-atom
 "Deep Atom theme port."
 'dark
 'modern-deep-atom-palette
 nil
 'modern-deep-atom-palette-overrides
 'modern-deep-atom-custom-faces)

(provide 'modern-deep-atom-theme)
;;; modern-deep-atom-theme.el ends here
