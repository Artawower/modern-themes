;;; modern-spacegray-light-theme.el --- Modern Spacegray Light theme port. -*- lexical-binding:t -*-

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
;; The `modern-spacegray-light' theme is a port based on modus-themes structure.

;;; Code:

(require 'modus-themes)

(defconst modern-spacegray-light-palette-partial
  '((cursor "#4A90E2")
    (bg-active "#d0d0d0")
    (bg-added "#e3e3e3")
    (bg-added-faint "#e3e3e3")
    (bg-added-refine "#acd2ac")
    (bg-alt "#d9d9d9")
    (bg-blue-intense "#adcdf1")
    (bg-blue-subtle "#d7e3f2")
    (bg-changed "#e3e3e3")
    (bg-changed-faint "#e3e3e3")
    (bg-changed-refine "#d2c5ac")
    (bg-completion "#d9d9d9")
    (bg-cyan-intense "#a7d3d3")
    (bg-cyan-subtle "#d6dfdf")
    (bg-dim "#e3e3e3")
    (bg-green-intense "#a7d3a7")
    (bg-green-subtle "#d6dfd6")
    (bg-hl-line "#e3e3e3")
    (bg-hover "#d9d9d9")
    (bg-hover-secondary "#d9d9d9")
    (bg-inactive "#F2F2F2")
    (bg-magenta-intense "#d7afeb")
    (bg-magenta-subtle "#e4d4ec")
    (bg-main "#F2F2F2")
    (bg-mode-line-active "#c7d9ed")
    (bg-red-intense "#ebafaf")
    (bg-red-subtle "#f0dbdb")
    (bg-removed "#e3e3e3")
    (bg-removed-faint "#e3e3e3")
    (bg-removed-refine "#d2acac")
    (bg-yellow-intense "#e7cf9f")
    (bg-yellow-subtle "#eae0cd")
    (blue "#4A90E2")
    (blue-cooler "#4a9ce1")
    (blue-faint "#5687c2")
    (blue-warmer "#4a83e1")
    (border "#cdcdcd")
    (cyan "#5FAFAF")
    (cyan-cooler "#5fafa8")
    (cyan-faint "#6c9090")
    (cyan-warmer "#5fa8af")
    (fg-added "#5FAF5F")
    (fg-alt "#575757")
    (fg-changed "#D7AF5F")
    (fg-dim "#6B6B6B")
    (fg-main "#2D2D2D")
    (fg-mode-line-active "#2D2D2D")
    (fg-removed "#D75F5F")
    (green "#5FAF5F")
    (green-cooler "#65af5f")
    (green-faint "#6c906c")
    (green-warmer "#5faf65")
    (magenta "#AF5FD7")
    (magenta-cooler "#a55fd7")
    (magenta-faint "#9e69b8")
    (magenta-warmer "#b95fd7")
    (red "#D75F5F")
    (red-cooler "#d75f68")
    (red-faint "#b86969")
    (red-warmer "#d7695f")
    (teal "#5faf93")
    (yellow "#D7AF5F")
    (yellow-cooler "#d7a55f")
    (yellow-faint "#b89e69")
    (yellow-warmer "#d7b95f")))

(defconst modern-spacegray-light-palette-common
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

(defconst modern-spacegray-light-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (fg-link blue)
    (fg-link-visited magenta)
    (name red)
    (keybind red)
    (identifier red)
    (fg-prompt magenta)

    (keyword magenta)
    (fnname blue)
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

(defcustom modern-spacegray-light-palette-overrides nil
  "Overrides for `modern-spacegray-light-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-spacegray-light
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-spacegray-light-palette
  (modus-themes-generate-palette
   modern-spacegray-light-palette-partial
   nil
   nil
   (append modern-spacegray-light-palette-mappings-partial modern-spacegray-light-palette-common)))

(defconst modern-spacegray-light-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-spacegray-light
 'modern-spacegray-light
 "Modern Spacegray Light theme port."
 'light
 'modern-spacegray-light-palette
 nil
 'modern-spacegray-light-palette-overrides
 'modern-spacegray-light-custom-faces)

(provide 'modern-spacegray-light-theme)
;;; modern-spacegray-light-theme.el ends here
