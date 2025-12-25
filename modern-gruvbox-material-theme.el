;;; modern-gruvbox-material-theme.el --- Modern Gruvbox Material theme port. -*- lexical-binding:t -*-

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
;; The `modern-gruvbox-material' theme is a port based on modus-themes structure.

;;; Code:

(require 'modus-themes)

(defconst modern-gruvbox-material-palette-partial
  '((cursor "#7aa2f7")
    (bg-active "#202020")
    (bg-added "#383432")
    (bg-added-faint "#383432")
    (bg-added-refine "#404331")
    (bg-alt "#383432")
    (bg-blue-intense "#c4dad5")
    (bg-blue-subtle "#e3e5e5")
    (bg-changed "#383432")
    (bg-changed-faint "#383432")
    (bg-changed-refine "#433c31")
    (bg-completion "#424141")
    (bg-cyan-intense "#bed5ba")
    (bg-cyan-subtle "#dfe2df")
    (bg-dim "#383432")
    (bg-green-intense "#cfd6aa")
    (bg-green-subtle "#e0e2d7")
    (bg-hl-line "#383432")
    (bg-hover "#424141")
    (bg-hover-secondary "#424141")
    (bg-inactive "#292828")
    (bg-magenta-intense "#e9c2cd")
    (bg-magenta-subtle "#ecdfe3")
    (bg-main "#292828")
    (bg-mode-line-active "#3e4946")
    (bg-orange-intense "#f1be9e")
    (bg-orange-subtle "#f1ddd0")
    (bg-red-intense "#f4b3b0")
    (bg-red-subtle "#f5dddc")
    (bg-removed "#383432")
    (bg-removed-faint "#383432")
    (bg-removed-refine "#433231")
    (bg-yellow-intense "#e7c99a")
    (bg-yellow-subtle "#eadecb")
    (blue "#7DAEA3")
    (blue-cooler "#7dae9e")
    (blue-faint "#86918e")
    (blue-warmer "#7daea7")
    (border "#494848")
    (cyan "#89B482")
    (cyan-cooler "#8db482")
    (cyan-faint "#8b9789")
    (cyan-warmer "#84b482")
    (fg-added "#A8B665")
    (fg-alt "#CCB692")
    (fg-changed "#D8A658")
    (fg-dim "#7C6F64")
    (fg-main "#D4BE98")
    (fg-mode-line-active "#D4BE98")
    (fg-removed "#EA6962")
    (green "#A8B665")
    (green-cooler "#aeb664")
    (green-faint "#919770")
    (green-warmer "#a1b664")
    (magenta "#D3859B")
    (magenta-cooler "#d385a1")
    (magenta-faint "#b78996")
    (magenta-warmer "#d38594")
    (orange "#E78A4F")
    (orange-cooler "#e67d4f")
    (orange-faint "#c78459")
    (orange-warmer "#e6964f")
    (red "#EA6962")
    (red-cooler "#e96266")
    (red-faint "#cc6e69")
    (red-warmer "#e97462")
    (teal "#93b477")
    (yellow "#D8A658")
    (yellow-cooler "#d89b57")
    (yellow-faint "#b89763")
    (yellow-warmer "#d8b057")))

(defconst modern-gruvbox-material-palette-common
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

(defconst modern-gruvbox-material-palette-mappings-partial
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
    (type blue)
    (constant red)
    (builtin blue)
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

(defcustom modern-gruvbox-material-palette-overrides nil
  "Overrides for `modern-gruvbox-material-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-gruvbox-material
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-gruvbox-material-palette
  (modus-themes-generate-palette
   modern-gruvbox-material-palette-partial
   nil
   nil
   (append modern-gruvbox-material-palette-mappings-partial modern-gruvbox-material-palette-common)))

(defconst modern-gruvbox-material-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-gruvbox-material
 'modern-gruvbox-material
 "Modern Gruvbox Material theme port."
 'dark
 'modern-gruvbox-material-palette
 nil
 'modern-gruvbox-material-palette-overrides
 'modern-gruvbox-material-custom-faces)

(provide 'modern-gruvbox-material-theme)
;;; modern-gruvbox-material-theme.el ends here
