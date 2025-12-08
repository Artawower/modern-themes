;;; modern-nano-dark-theme.el --- Modern Nano Dark theme port -*- lexical-binding:t -*-

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
;; The `modern-nano-dark' theme is a port of the Nano Dark theme
;; to the `modus-themes' structure.
;; It follows the N Λ N O aesthetic: roughly monochrome with few accents.

;;; Code:

(require 'modus-themes)

(defconst modern-nano-dark-palette-partial
  '((cursor "#ECEFF4")
    (bg-main "#2E3440")
    (bg-dim "#242832")
    (bg-alt "#242832")
    (fg-main "#ECEFF4")
    (fg-dim "#677691")
    (fg-alt "#677691")
    (bg-active "#3B4252")
    (bg-inactive "#2E3440")
    (border "#3B4252")

    ;; Nano Palette
    ;; Salient: #81A1C1 (Blueish)
    ;; Popout:  #D08770 (Orange)
    ;; Critical: #EBCB8B (Yellow)
    ;; Strong:   #FFFFFF (White)

    (red "#EF5350")
    (red-warmer "#D08770")
    (red-cooler "#EF5350")
    (red-faint "#c24552")
    (green "#66BB6A")
    (green-warmer "#66BB6A")
    (green-cooler "#66BB6A")
    (green-faint "#61756c")
    (yellow "#FFEE58")
    (yellow-warmer "#D08770")
    (yellow-cooler "#EBCB8B")
    (yellow-faint "#9a5f6a")
    (blue "#677691")
    (blue-warmer "#42A5F5")
    (blue-cooler "#81A1C1")
    (blue-faint "#1c4a6e")
    (magenta "#AB47BC")
    (magenta-warmer "#AB47BC")
    (magenta-cooler "#81A1C1")
    (magenta-faint "#a45392")
    (cyan "#677691")
    (cyan-warmer "#26C6DA")
    (cyan-cooler "#81A1C1")
    (cyan-faint "#5699AF")
    (teal "#677691")

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

    (bg-region-col "#434C5E")))

(defconst modern-nano-dark-palette-common
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

(defconst modern-nano-dark-palette-mappings-partial
  '((err red-warmer)
    (warning yellow-warmer)
    (warning yellow-warmer)
    (info blue-cooler)

    (bg-mode-line-active bg-active)
    (fg-mode-line-active fg-main)

    (bg-completion bg-dim)
    (bg-hover bg-active)
    (bg-hover-secondary bg-active)
    (bg-hl-line bg-active)
    (bg-paren-match bg-region-col)
    (bg-err yellow-cooler)
    (bg-warning yellow-warmer)
    (bg-info blue-cooler)
    (bg-region bg-region-col)

    (fg-link blue-cooler)
    (fg-link-visited blue-cooler)
    (name fg-main)
    (keybind blue-cooler)
    (identifier fg-main)
    (fg-prompt blue-cooler)

    (builtin blue-cooler)
    (comment fg-dim)
    (constant fg-main)
    (fnname fg-main)
    (fnname-call fg-main)
    (keyword blue-cooler)
    (preprocessor blue-cooler)
    (docstring fg-dim)
    (string fg-dim)
    (type blue-cooler)
    (variable fg-main)
    (property fg-main)
    (variable-use fg-main)
    (rx-backslash blue-cooler)
    (rx-construct blue-cooler)

    (accent-0 fg-main)
    (accent-1 fg-main)
    (accent-2 fg-main)
    (accent-3 fg-main)

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

    (fg-prose-code fg-dim)
    (prose-done green)
    (fg-prose-macro blue-cooler)
    (prose-metadata fg-dim)
    (prose-metadata-value fg-alt)
    (prose-table fg-alt)
    (prose-table-formula info)
    (prose-tag yellow-faint)
    (prose-todo red)
    (fg-prose-verbatim blue-cooler)

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

    (rainbow-0 fg-main)
    (rainbow-1 fg-main)
    (rainbow-2 fg-main)
    (rainbow-3 fg-main)
    (rainbow-4 fg-main)
    (rainbow-5 fg-main)
    (rainbow-6 fg-main)
    (rainbow-7 fg-main)
    (rainbow-8 fg-main)))

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
