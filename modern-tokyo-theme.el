;;; modern-tokyo-theme.el --- Modern Tokyo theme port -*- lexical-binding:t -*-

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
;; The `modern-tokyo' theme is a port of the Tokio Night theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-tokyo-palette-partial
  '((cursor "#7aa2f7")
    (bg-main "#24283b")
    (bg-dim "#1f2335")
    (bg-alt "#1f2335")
    (fg-main "#c0caf5")
    (fg-dim "#4e567a")
    (fg-alt "#a9b1d6")
    (bg-active "#343955")
    (bg-inactive "#24283b")
    (border "#343955")

    (red "#f7768e")
    (red-warmer "#f7768e")
    (red-cooler "#f7768e")
    (red-faint "#c24552")
    (green "#9ece6a")
    (green-warmer "#9ece6a")
    (green-cooler "#9ece6a")
    (green-faint "#61756c")
    (yellow "#e0af68")
    (yellow-warmer "#ff9e64")
    (yellow-cooler "#e0af68")
    (yellow-faint "#9a5f6a")
    (blue "#7aa2f7")
    (blue-warmer "#7aa2f7")
    (blue-cooler "#1c4a6e")
    (blue-faint "#1c4a6e")
    (magenta "#bb9af7")
    (magenta-warmer "#bb9af7")
    (magenta-cooler "#9d7cd8")
    (magenta-faint "#a45392")
    (cyan "#7dcfff")
    (cyan-warmer "#7dcfff")
    (cyan-cooler "#5699AF")
    (cyan-faint "#5699AF")
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

    (bg-added "#283B4D")
    (bg-added-faint "#1f2d3a")
    (bg-added-refine "#335066")
    (fg-added "#9ece6a")

    (bg-removed "#3F2D3D")
    (bg-removed-faint "#2e212d")
    (bg-removed-refine "#523647")
    (fg-removed "#f7768e")

    (bg-changed "#3E2E1E")
    (bg-changed-faint "#2e2118")
    (bg-changed-refine "#4d3a28")
    (fg-changed "#e0af68")

    (bg-mode-line-active "#1c4a6e")
    (fg-mode-line-active "#c0caf5")

    (bg-completion "#343955")
    (bg-hover "#343955")
    (bg-hover-secondary "#343955")
    (bg-hl-line "#1f2335")))

(defconst modern-tokyo-palette-common
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
    (fg-heading-8 rainbow-8)))

(defconst modern-tokyo-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

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
    (keyword magenta-cooler)
    (preprocessor blue)
    (docstring fg-dim)
    (string green)
    (type yellow)
    (variable red)
    (property blue)
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

(defcustom modern-tokyo-palette-overrides nil
  "Overrides for `modern-tokyo-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-tokyo
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-tokyo-palette
  (modus-themes-generate-palette
   modern-tokyo-palette-partial
   nil
   nil
   (append modern-tokyo-palette-mappings-partial modern-tokyo-palette-common)))

(defconst modern-tokyo-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-tokyo
 'modern-tokyo
 "Modern Tokyo theme port."
 'dark
 'modern-tokyo-palette
 nil
 'modern-tokyo-palette-overrides
 'modern-tokyo-custom-faces)

(provide 'modern-tokyo-theme)
;;; modern-tokyo-theme.el ends here
