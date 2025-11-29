;;; modern-pinkywinky-theme.el --- Legible light theme inspired by Pinky Winky -*- lexical-binding:t -*-

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
;; The `modern-pinkywinky' theme is a port of the Pinky Winky theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-pinkywinky-palette-partial
  '((cursor "#00AEE8")
    (bg-main "#f8f8ff")
    (bg-dim "#fafafa")
    (bg-alt "#efefef")
    (fg-main "#44425e")
    (fg-dim "#73797e")
    (fg-alt "#A09BB3")
    (bg-active "#dfdfdf")
    (bg-inactive "#f8f8ff")
    (border "#c6c7c7")

    (red "#FF3399")
    (red-warmer "#f65866")
    (red-cooler "#d50f7f")
    (red-faint "#c24552")
    (green "#00D364")
    (green-warmer "#4a7d00")
    (green-cooler "#007f68")
    (green-faint "#61756c")
    (yellow "#FFAA00")
    (yellow-warmer "#b6532f")
    (yellow-cooler "#b65050")
    (yellow-faint "#9a5f6a")
    (blue "#00AEE8")
    (blue-warmer "#5250ef")
    (blue-cooler "#065fff")
    (blue-faint "#6060d0")
    (magenta "#CC66FF")
    (magenta-warmer "#c75ae8")
    (magenta-cooler "#8e44f3")
    (magenta-faint "#a45392")
    (cyan "#00CED1")
    (cyan-warmer "#3f6faf")
    (cyan-cooler "#0f7b8f")
    (cyan-faint "#5f60bf")

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

    (bg-added "#caf4da")
    (bg-added-faint "#dff6ea")
    (bg-added-refine "#bae9cf")
    (fg-added "#005000")

    (bg-changed "#ffdfb9")
    (bg-changed-faint "#ffefcb")
    (bg-changed-refine "#ffcfa0")
    (fg-changed "#553d00")

    (bg-removed "#ffcee0")
    (bg-removed-faint "#ffdfe6")
    (bg-removed-refine "#f5b6c8")
    (fg-removed "#8f1313")

    (bg-mode-line-active "#dfdfdf")
    (fg-mode-line-active "#44425e")

    (bg-completion "#f4cfff")
    (bg-hover "#b4cfff")
    (bg-hover-secondary "#aaeccf")
    (bg-hl-line "#fafafa")
    (bg-paren-match "#9fc0ef")
    (bg-err "#ffd0e6")
    (bg-warning "#ffe5ba")
    (bg-info "#bbefda")
    (bg-region "#eecfff")))

(defconst modern-pinkywinky-palette-common
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

(defconst modern-pinkywinky-palette-mappings-partial
  '((err red-warmer)
    (warning yellow)
    (info green-cooler)

    (fg-link blue)
    (fg-link-visited green-cooler)
    (name magenta-warmer)
    (keybind red-cooler)
    (identifier magenta-faint)
    (fg-prompt magenta-warmer)

    (builtin blue)
    (comment fg-dim)
    (constant red)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta-warmer)
    (preprocessor blue)
    (docstring cyan-faint)
    (string green)
    (type yellow)
    (variable red)
    (variable-use red)
    (rx-backslash cyan-cooler)
    (rx-construct red-cooler)

    (accent-0 magenta-cooler)
    (accent-1 yellow)
    (accent-2 cyan-cooler)
    (accent-3 red)

    (date-common cyan-cooler)
    (date-deadline red-warmer)
    (date-deadline-subtle red-faint)
    (date-event fg-alt)
    (date-holiday magenta-warmer)
    (date-now fg-main)
    (date-range fg-alt)
    (date-scheduled yellow)
    (date-scheduled-subtle yellow-faint)
    (date-weekday cyan)
    (date-weekend red-faint)

    (fg-prose-code yellow)
    (prose-done green-cooler)
    (fg-prose-macro cyan-cooler)
    (prose-metadata fg-dim)
    (prose-metadata-value fg-alt)
    (prose-table fg-alt)
    (prose-table-formula info)
    (prose-tag yellow-faint)
    (prose-todo red-warmer)
    (fg-prose-verbatim magenta-cooler)

    (mail-cite-0 yellow-cooler)
    (mail-cite-1 magenta)
    (mail-cite-2 blue-warmer)
    (mail-cite-3 cyan-warmer)
    (mail-part magenta-faint)
    (mail-recipient magenta-warmer)
    (mail-subject magenta-cooler)
    (mail-other magenta)

    (bg-search-static bg-warning)
    (bg-search-current bg-yellow-intense)
    (bg-search-lazy bg-blue-intense)
    (bg-search-replace bg-red-intense)

    (bg-search-rx-group-0 bg-magenta-intense)
    (bg-search-rx-group-1 bg-green-intense)
    (bg-search-rx-group-2 bg-red-subtle)
    (bg-search-rx-group-3 bg-cyan-subtle)

    (rainbow-0 magenta-warmer)
    (rainbow-1 magenta-cooler)
    (rainbow-2 yellow)
    (rainbow-3 cyan)
    (rainbow-4 magenta)
    (rainbow-5 blue-warmer)
    (rainbow-6 red-cooler)
    (rainbow-7 cyan-cooler)
    (rainbow-8 yellow-cooler)))

(defcustom modern-pinkywinky-palette-overrides nil
  "Overrides for `modern-pinkywinky-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-pinkywinky
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-pinkywinky-palette
  (modus-themes-generate-palette
   modern-pinkywinky-palette-partial
   nil
   nil
   (append modern-pinkywinky-palette-mappings-partial modern-pinkywinky-palette-common)))

(defconst modern-pinkywinky-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-pinkywinky
 'modern-pinkywinky
 "Legible light theme inspired by Pinky Winky."
 'light
 'modern-pinkywinky-palette
 nil
 'modern-pinkywinky-palette-overrides
 'modern-pinkywinky-custom-faces)

(provide 'modern-pinkywinky-theme)
;;; modern-pinkywinky-theme.el ends here
