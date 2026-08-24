;;; modern-nano-dark-theme.el --- Modern Nano Dark theme port. -*- lexical-binding:t -*-

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
;; The `modern-nano-dark' theme is a port based on modus-themes structure.

;;; Code:

(require 'modus-themes)

(defconst modern-nano-dark-palette-partial
  '((cursor "#ECEFF4")
    (bg-active "#434C5D")
    (bg-added "#242832")
    (bg-added-faint "#242832")
    (bg-added-refine "#394331")
    (bg-alt "#242832")
    (bg-blue-intense "#c6d4e3")
    (bg-blue-subtle "#e3e7ea")
    (bg-changed "#242832")
    (bg-changed-faint "#242832")
    (bg-changed-refine "#433d31")
    (bg-completion "#474c56")
    (bg-cyan-intense "#bddce5")
    (bg-cyan-subtle "#e0e9eb")
    (bg-dim "#242832")
    (bg-green-intense "#ccdbbf")
    (bg-green-subtle "#e3e6e1")
    (bg-hl-line "#242832")
    (bg-hover "#474c56")
    (bg-hover-secondary "#474c56")
    (bg-inactive "#2E3440")
    (bg-magenta-intense "#d9c6d6")
    (bg-magenta-subtle "#e2e2e2")
    (bg-main "#2E3440")
    (bg-mode-line-active "#424f60")
    (bg-orange-intense "#ffaf72")
    (bg-orange-subtle "#f7d4ba")
    (bg-red-intense "#e7c3b7")
    (bg-red-subtle "#eee3e0")
    (bg-removed "#242832")
    (bg-removed-faint "#242832")
    (bg-removed-refine "#433631")
    (bg-yellow-intense "#f3dfb9")
    (bg-yellow-subtle "#f3ebda")
    (blue "#81A1C1")
    (blue-cooler "#81a6c1")
    (blue-faint "#8796a5")
    (blue-warmer "#819bc1")
    (border "#4d525c")
    (cyan "#88C0D0")
    (cyan-cooler "#88c5d0")
    (cyan-faint "#8cabb4")
    (cyan-warmer "#88bad0")
    (fg-alt "#919caf")
    (fg-dim "#919caf")
    (fg-main "#ECEFF4")
    (fg-mode-line-active "#ECEFF4")
    (green "#A3BE8C")
    (green-cooler "#a7be8c")
    (green-faint "#99a391")
    (green-warmer "#9ebe8c")
    (magenta "#B48EAD")
    (magenta-cooler "#b38eb0")
    (magenta-faint "#989497")
    (magenta-warmer "#b38ea9")
    (orange "#FF6F00")
    (orange-cooler "#ff5900")
    (orange-faint "#d96914")
    (orange-warmer "#ff8400")
    (red "#D08770")
    (red-cooler "#d07f70")
    (red-faint "#b38678")
    (red-warmer "#d08f70")
    (teal "#91bfb8")
    (yellow "#EBCB8B")
    (yellow-cooler "#ebc38a")
    (yellow-faint "#d1ba8c")
    (yellow-warmer "#ebd38a")))

(defconst modern-nano-dark-palette-common
  '((fringe unspecified)
    (fg-region unspecified)
    (fg-added unspecified)
    (fg-changed unspecified)
    (fg-removed unspecified)
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

(defconst modern-nano-dark-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (fg-link blue)
    (fg-link-visited magenta)
    (name red)
    (keybind red)
    (identifier red)
    (fg-prompt magenta)

    ;; Keep ANSI neutral foregrounds readable in terminal packages such as
    ;; Ghostel while leaving their background mappings to modus-themes.
    (fg-term-black fg-dim)
    (fg-term-black-bright fg-dim)
    (fg-term-white fg-dim)
    (fg-term-white-bright fg-main)

    (keyword blue-cooler)
    (fnname fg-main)
    (fnname-call blue)
    (variable fg-main)
    (property fg-main)
    (string green)
    (type blue-cooler)
    (constant fg-main)
    (builtin blue)
    (comment fg-dim)
    (docstring fg-dim)
    (preprocessor blue)
    (rx-backslash cyan)
    (rx-construct red)
    (rainbow-0 fg-main)
    (rainbow-1 fg-main)
    (rainbow-2 fg-main)
    (rainbow-3 fg-main)
    (rainbow-4 fg-main)
    (rainbow-5 fg-main)
    (rainbow-6 fg-main)
    (rainbow-7 fg-main)
    (rainbow-8 fg-main)
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

(defcustom modern-nano-dark-palette-overrides nil
  "Overrides for `modern-nano-dark-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-nano-dark
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-nano-dark-palette
  (modus-themes-generate-palette
   modern-nano-dark-palette-partial
   nil
   nil
   (append modern-nano-dark-palette-mappings-partial modern-nano-dark-palette-common)))

(defconst modern-nano-dark-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-nano-dark
 'modern-nano-dark
 "Modern Nano Dark theme port."
 'dark
 'modern-nano-dark-palette
 nil
 'modern-nano-dark-palette-overrides
 'modern-nano-dark-custom-faces)

(provide 'modern-nano-dark-theme)
;;; modern-nano-dark-theme.el ends here
