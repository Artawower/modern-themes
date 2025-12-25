;;; modern-spacegray-theme.el --- Modern Gruvbox Material theme port. -*- lexical-binding:t -*-

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
;; The `modern-spacegray' theme is a port based on modus-themes structure.

;;; Code:

(require 'modus-themes)

(defconst modern-spacegray-palette-partial
  '((cursor "#D18770")
    (bg-active "#353a44")
    (bg-added "#262b35")
    (bg-added-faint "#262b35")
    (bg-added-refine "#394331")
    (bg-alt "#262b35")
    (bg-blue-intense "#ccd4dc")
    (bg-blue-subtle "#e7e7e7")
    (bg-changed "#262b35")
    (bg-changed-faint "#262b35")
    (bg-changed-refine "#433931")
    (bg-completion "#444852")
    (bg-cyan-intense "#9fb6b4")
    (bg-cyan-subtle "#d1d1d1")
    (bg-dim "#262b35")
    (bg-green-intense "#ccdbbf")
    (bg-green-subtle "#e3e6e1")
    (bg-hl-line "#262b35")
    (bg-hover "#444852")
    (bg-hover-secondary "#444852")
    (bg-inactive "#2B303B")
    (bg-magenta-intense "#d2bfd1")
    (bg-magenta-subtle "#dedede")
    (bg-main "#2B303B")
    (bg-mode-line-active "#444c59")
    (bg-red-intense "#e8c3b7")
    (bg-red-subtle "#eee3df")
    (bg-removed "#262b35")
    (bg-removed-faint "#262b35")
    (bg-removed-refine "#433631")
    (bg-yellow-intense "#edc19d")
    (bg-yellow-subtle "#eddbcc")
    (blue "#8FA1B3")
    (blue-cooler "#8fa3b3")
    (blue-faint "#959697")
    (blue-warmer "#8f9eb3")
    (border "#4a4f58")
    (cyan "#527C77")
    (cyan-cooler "#527c73")
    (cyan-faint "#5d6262")
    (cyan-warmer "#527c7a")
    (fg-added "#A3BE8C")
    (fg-alt "#898c89")
    (fg-changed "#E2995C")
    (fg-dim "#636574")
    (fg-main "#B7BBB7")
    (fg-mode-line-active "#B7BBB7")
    (fg-removed "#D18770")
    (green "#A3BE8C")
    (green-cooler "#a7be8c")
    (green-faint "#99a391")
    (green-warmer "#9ebe8c")
    (magenta "#A57FA3")
    (magenta-cooler "#a37ea5")
    (magenta-faint "#888888")
    (magenta-warmer "#a57e9f")
    (red "#D18770")
    (red-cooler "#d07e70")
    (red-faint "#b38678")
    (red-warmer "#d08f70")
    (teal "#6e937e")
    (yellow "#E2995C")
    (yellow-cooler "#e28d5c")
    (yellow-faint "#c39065")
    (yellow-warmer "#e2a45c")))

(defconst modern-spacegray-palette-common
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

(defconst modern-spacegray-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (fg-link blue)
    (fg-link-visited magenta)
    (name red)
    (keybind red)
    (identifier red)
    (fg-prompt magenta)

    (keyword red)
    (fnname orange)
    (fnname-call blue)
    (variable fg-main)
    (property blue)
    (string green)
    (type yellow)
    (constant red)
    (builtin red)
    (comment fg-dim)
    (docstring fg-dim)
    (preprocessor blue)
    (rx-backslash cyan)
    (rx-construct red)
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

(defcustom modern-spacegray-palette-overrides nil
  "Overrides for `modern-spacegray-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-spacegray
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-spacegray-palette
  (modus-themes-generate-palette
   modern-spacegray-palette-partial
   nil
   nil
   (append modern-spacegray-palette-mappings-partial modern-spacegray-palette-common)))

(defconst modern-spacegray-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-spacegray
 'modern-spacegray
 "Modern Gruvbox Material theme port."
 'dark
 'modern-spacegray-palette
 nil
 'modern-spacegray-palette-overrides
 'modern-spacegray-custom-faces)

(provide 'modern-spacegray-theme)
;;; modern-spacegray-theme.el ends here
