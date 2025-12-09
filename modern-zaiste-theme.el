;;; modern-zaiste-theme.el --- Modern Zaiste theme port -*- lexical-binding:t -*-

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
;; The `modern-zaiste' theme is a port of the Zaiste theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-zaiste-palette-partial
  '((cursor "#0098dd")
    (bg-main "#f0f0f0")
    (bg-dim "#fafafa")
    (bg-alt "#fafafa")
    (fg-main "#383a42")
    (fg-dim "#a0a1a7")
    (fg-alt "#c6c7c7")
    (bg-active "#dfdfdf")
    (bg-inactive "#f0f0f0")
    (border "#c6c7c7")

    (red "#e45649")
    (red-warmer "#f65866")
    (red-cooler "#e45649")
    (red-faint "#f2a1a1")
    (green "#50a14f")
    (green-warmer "#98c379")
    (green-cooler "#50a14f")
    (green-faint "#a3d4a3")
    (yellow "#bda800")
    (yellow-warmer "#da8548")
    (yellow-cooler "#bda800")
    (yellow-faint "#e8d888")
    (blue "#0098dd")
    (blue-warmer "#275fe4")
    (blue-cooler "#0098dd")
    (blue-faint "#d2ecff")
    (magenta "#a626a4")
    (magenta-warmer "#a626a4")
    (magenta-cooler "#823ff1")
    (magenta-faint "#dcbce8")
    (cyan "#0184bc")
    (cyan-warmer "#0184bc")
    (cyan-cooler "#4db5bd")
    (cyan-faint "#aee2f2")
    (teal "#4db5bd")

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

    (bg-added "#d6f5d6")
    (bg-added-faint "#ecfcec")
    (bg-added-refine "#bef5be")
    (fg-added "#005000")

    (bg-changed "#ffecb3")
    (bg-changed-faint "#fff6da")
    (bg-changed-refine "#ffdd80")
    (fg-changed "#553d00")

    (bg-removed "#ffccd6")
    (bg-removed-faint "#ffe6eb")
    (bg-removed-refine "#ff99aa")
    (fg-removed "#8f1313")

    (bg-mode-line-active-col "#e7e7e7")))

(defconst modern-zaiste-palette-common
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
    (bg-mark-select bg-blue-intense)
    (fg-mark-select blue)
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

(defconst modern-zaiste-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active bg-mode-line-active-col)
    (fg-mode-line-active fg-main)

    (bg-completion blue-faint)
    (bg-hover blue-faint)
    (bg-hover-secondary blue-faint)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region blue-faint)

    (fg-link blue)
    (fg-link-visited magenta)
    (name red)
    (keybind red)
    (identifier red)
    (fg-prompt magenta)

    (builtin magenta)
    (comment fg-dim)
    (constant magenta-cooler)
    (fnname green)
    (fnname-call green)
    (keyword blue)
    (preprocessor blue)
    (docstring fg-dim)
    (string yellow)
    (type red)
    (variable fg-main)
    (variable-use magenta)
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

    (rainbow-0 magenta)
    (rainbow-1 magenta)
    (rainbow-2 yellow)
    (rainbow-3 cyan)
    (rainbow-4 magenta)
    (rainbow-5 blue)
    (rainbow-6 red)
    (rainbow-7 cyan)
    (rainbow-8 yellow)))

(defcustom modern-zaiste-palette-overrides nil
  "Overrides for `modern-zaiste-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-zaiste
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-zaiste-palette
  (modus-themes-generate-palette
   modern-zaiste-palette-partial
   nil
   nil
   (append modern-zaiste-palette-mappings-partial modern-zaiste-palette-common)))

(defconst modern-zaiste-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-zaiste
 'modern-zaiste
 "Modern Zaiste theme port."
 'light
 'modern-zaiste-palette
 nil
 'modern-zaiste-palette-overrides
 'modern-zaiste-custom-faces)

(provide 'modern-zaiste-theme)
;;; modern-zaiste-theme.el ends here
