;;; modern-liac-dark-theme.el --- Liac Dark theme port -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation

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
;; The `modern-liac-dark' theme is a port of the Liac VSCode dark
;; color scheme to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-liac-dark-palette-partial
  '((cursor "#E0CEED")
    (bg-main "#080709")
    (bg-dim  "#050406")
    (bg-alt  "#100F14")
    (fg-main "#E0CEED")
    (fg-dim  "#7A6F8F")
    (fg-alt  "#C8B4F0")
    (bg-active "#2B2638")
    (bg-inactive "#080709")
    (border      "#262131")

    (red           "#FF7A9B")
    (red-warmer    "#FF8FAF")
    (red-cooler    "#E06788")
    (red-faint     "#B24F68")

    (green         "#8BE9B4")
    (green-warmer  "#A1F1C4")
    (green-cooler  "#6EC99A")
    (green-faint   "#4F9C74")

    (yellow        "#FFD27E")
    (yellow-warmer "#FFE09A")
    (yellow-cooler "#E0B96A")
    (yellow-faint  "#B69051")

    (blue          "#A29DFA")
    (blue-warmer   "#B7B2FF")
    (blue-cooler   "#7F8BE0")
    (blue-faint    "#6A70C5")

    (magenta        "#B657FF")
    (magenta-warmer "#C86CFF")
    (magenta-cooler "#9E4AE5")
    (magenta-faint  "#8B4BC9")

    (cyan        "#8E6DA6")
    (cyan-warmer "#A785C3")
    (cyan-cooler "#74578A")
    (cyan-faint  "#5D446E")
    (teal        "#8E6DA6")

    (bg-red-intense     "#3A1A24")
    (bg-green-intense   "#152820")
    (bg-yellow-intense  "#2E2416")
    (bg-blue-intense    "#15162A")
    (bg-magenta-intense "#221327")
    (bg-cyan-intense    "#171520")

    (bg-red-subtle     "#301821")
    (bg-green-subtle   "#14241E")
    (bg-yellow-subtle  "#272016")
    (bg-blue-subtle    "#1A1B2A")
    (bg-magenta-subtle "#201328")
    (bg-cyan-subtle    "#1A1624")

    (bg-added         "#132019")
    (bg-added-faint   "#0E1812")
    (bg-added-refine  "#1C3425")
    (fg-added         "#A5E6B7")

    (bg-changed        "#251E12")
    (bg-changed-faint  "#19140D")
    (bg-changed-refine "#3A2B18")
    (fg-changed        "#FFD27E")

    (bg-removed        "#291621")
    (bg-removed-faint  "#1D0F18")
    (bg-removed-refine "#3D1E2E")
    (fg-removed        "#FF8FAF")))

(defconst modern-liac-dark-palette-common
  '((fringe unspecified)
    (fg-region unspecified)

    (bg-diff-context bg-dim)
    (bg-diff-focus bg-dim)
    (bg-diff-text bg-active)
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

(defconst modern-liac-dark-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active bg-active)
    (fg-mode-line-active fg-main)

    (bg-hover bg-active)
    (bg-completion bg-active)
    (bg-hover-secondary bg-active)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-active)

    (fg-link blue)
    (fg-link-visited magenta)
    (name magenta)
    (keybind magenta)
    (identifier magenta)
    (fg-prompt magenta)

    (builtin magenta)
    (comment fg-dim)
    (constant yellow)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta-warmer)
    (preprocessor magenta-cooler)
    (docstring cyan)
    (string cyan)
    (type blue-faint)
    (variable fg-main)
    (property cyan)
    (variable-use fg-main)
    (rx-backslash cyan)
    (rx-construct yellow)

    (accent-0 magenta)
    (accent-1 blue)
    (accent-2 cyan)
    (accent-3 yellow)

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

    (fg-prose-code cyan)
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
    (mail-subject fg-main)
    (mail-other magenta)

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

    (bg-search-rx-group-0 bg-magenta-intense)
    (bg-search-rx-group-1 bg-green-intense)
    (bg-search-rx-group-2 bg-red-subtle)
    (bg-search-rx-group-3 bg-cyan-subtle)

    (rainbow-0 magenta)
    (rainbow-1 blue)
    (rainbow-2 cyan)
    (rainbow-3 yellow)
    (rainbow-4 magenta-warmer)
    (rainbow-5 blue-faint)
    (rainbow-6 cyan-faint)
    (rainbow-7 yellow-faint)
    (rainbow-8 magenta-cooler)))

(defcustom modern-liac-dark-palette-overrides nil
  "Overrides for `modern-liac-dark-palette'."
  :group 'modern-liac-dark
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-liac-dark-palette
  (modus-themes-generate-palette
   modern-liac-dark-palette-partial
   nil
   nil
   (append modern-liac-dark-palette-mappings-partial
           modern-liac-dark-palette-common)))

(defconst modern-liac-dark-custom-faces
  '(`(magit-section-highlight
      ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight
      ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-liac-dark
 'modern-liac-dark
 "Liac VSCode Dark theme port."
 'dark
 'modern-liac-dark-palette
 nil
 'modern-liac-dark-palette-overrides
 'modern-liac-dark-custom-faces)

(provide 'modern-liac-dark-theme)

;;; modern-liac-dark-theme.el ends here
