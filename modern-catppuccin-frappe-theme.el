;;; modern-catppuccin-frappe-theme.el --- Catppuccin Frappe theme port -*- lexical-binding:t -*-

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
;; The `modern-catppuccin-frappe' theme is a port of the Catppuccin Frappe theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-catppuccin-frappe-palette-partial
  '((cursor "#f2d5cf")
    (bg-main "#303446")
    (bg-dim "#232634")
    (bg-alt "#414559")
    (fg-main "#c6d0f5")
    (fg-dim "#a5adce")
    (fg-alt "#b5bfe2")
    (bg-active "#626880")
    (bg-inactive "#292c3c")
    (border "#737994")

    (red "#e78284")
    (red-warmer "#ea999c")
    (red-cooler "#eebebe")
    (red-faint "#b85658")
    (green "#a6d189")
    (green-warmer "#a6d189")
    (green-cooler "#81c8be")
    (green-faint "#7ba260")
    (yellow "#e5c890")
    (yellow-warmer "#ef9f76")
    (yellow-cooler "#e5c890")
    (yellow-faint "#b69961")
    (blue "#8caaee")
    (blue-warmer "#85c1dc")
    (blue-cooler "#babbf1")
    (blue-faint "#5b7ac0")
    (magenta "#ca9ee6")
    (magenta-warmer "#f4b8e4")
    (magenta-cooler "#ca9ee6")
    (magenta-faint "#9a6ab8")
    (cyan "#99d1db")
    (cyan-warmer "#81c8be")
    (cyan-cooler "#85c1dc")
    (cyan-faint "#6aa2ac")
    (teal "#81c8be")

    (bg-red-intense "#664b58")
    (bg-green-intense "#53635a")
    (bg-yellow-intense "#66605c")
    (bg-blue-intense "#4b5778")
    (bg-magenta-intense "#5e5376")
    (bg-cyan-intense "#4f6372")

    (bg-red-subtle "#4b3f4f")
    (bg-green-subtle "#414b50")
    (bg-yellow-subtle "#4b4a51")
    (bg-blue-subtle "#3d455f")
    (bg-magenta-subtle "#47435e")
    (bg-cyan-subtle "#3f4b5c")

    (bg-added "#a6d189")
    (bg-added-faint "#a6d189")
    (bg-added-refine "#a6d189")
    (fg-added "#303446")

    (bg-changed "#e5c890")
    (bg-changed-faint "#e5c890")
    (bg-changed-refine "#e5c890")
    (fg-changed "#303446")

    (bg-removed "#e78284")
    (bg-removed-faint "#e78284")
    (bg-removed-refine "#e78284")
    (fg-removed "#303446")

    ;; Unique colors needed for mappings
    (bg-mode-line-active-col "#51576d") ;; Surface1
    (bg-hover-col "#626880") ;; Surface2
    (bg-hover-secondary-col "#51576d") ;; Surface1
    (bg-paren-match-col "#737994") ;; Overlay0
    (fg-heading-0-col "#e78284") ;; Red
    (fg-heading-1-col "#ef9f76") ;; Peach
    (fg-heading-2-col "#e5c890") ;; Yellow
    (fg-heading-3-col "#a6d189") ;; Green
    (fg-heading-4-col "#85c1dc") ;; Sapphire
    (fg-heading-5-col "#8caaee") ;; Blue
    (fg-heading-6-col "#babbf1") ;; Lavender
    (fg-heading-7-col "#ca9ee6") ;; Mauve
    (fg-heading-8-col "#f4b8e4"))) ;; Pink

(defconst modern-catppuccin-frappe-palette-common
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

(defconst modern-catppuccin-frappe-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active bg-mode-line-active-col)
    (fg-mode-line-active fg-main)

    (bg-completion bg-dim)
    (bg-hover bg-hover-col)
    (bg-hover-secondary bg-hover-secondary-col)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-paren-match-col)
    (bg-err red)
    (bg-warning yellow)
    (bg-info blue)
    (bg-region bg-active)

    (fg-link blue)
    (fg-link-visited blue-cooler)
    (name magenta)
    (keybind red)
    (identifier magenta-warmer)
    (fg-prompt magenta)

    (builtin red)
    (comment fg-dim)
    (constant yellow-warmer)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta)
    (preprocessor red-faint)
    (docstring fg-dim)
    (string green)
    (type yellow)
    (variable fg-main)
    (property fg-main)
    (variable-use fg-main)
    (rx-backslash cyan-warmer)
    (rx-construct yellow-warmer)

    (accent-0 magenta)
    (accent-1 yellow)
    (accent-2 blue)
    (accent-3 red)

    (date-common cyan-warmer)
    (date-deadline red)
    (date-deadline-subtle red-faint)
    (date-event fg-alt)
    (date-holiday red-cooler)
    (date-now fg-main)
    (date-range fg-alt)
    (date-scheduled yellow)
    (date-scheduled-subtle yellow)
    (date-weekday cyan-warmer)
    (date-weekend red-faint)

    (fg-prose-code yellow)
    (prose-done green)
    (fg-prose-macro magenta)
    (prose-metadata fg-dim)
    (prose-metadata-value fg-alt)
    (prose-table fg-alt)
    (prose-table-formula info)
    (prose-tag yellow-warmer)
    (prose-todo red)
    (fg-prose-verbatim magenta)

    (mail-cite-0 yellow)
    (mail-cite-1 magenta)
    (mail-cite-2 blue)
    (mail-cite-3 cyan-warmer)
    (mail-part magenta-warmer)
    (mail-recipient magenta)
    (mail-subject fg-main)
    (mail-other magenta)

    (bg-search-static bg-warning)
    (bg-search-current yellow)
    (bg-search-lazy blue)
    (bg-search-replace red)

    (bg-search-rx-group-0 magenta)
    (bg-search-rx-group-1 green)
    (bg-search-rx-group-2 red)
    (bg-search-rx-group-3 cyan-warmer)

    (rainbow-0 fg-heading-0-col)
    (rainbow-1 fg-heading-1-col)
    (rainbow-2 fg-heading-2-col)
    (rainbow-3 fg-heading-3-col)
    (rainbow-4 fg-heading-4-col)
    (rainbow-5 fg-heading-5-col)
    (rainbow-6 fg-heading-6-col)
    (rainbow-7 fg-heading-7-col)
    (rainbow-8 fg-heading-8-col)))

(defcustom modern-catppuccin-frappe-palette-overrides nil
  "Overrides for `modern-catppuccin-frappe-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-catppuccin-frappe
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-catppuccin-frappe-palette
  (modus-themes-generate-palette
   modern-catppuccin-frappe-palette-partial
   nil
   nil
   (append modern-catppuccin-frappe-palette-mappings-partial modern-catppuccin-frappe-palette-common)))

(defconst modern-catppuccin-frappe-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-catppuccin-frappe
 'modern-catppuccin-frappe
 "Catppuccin Frappe theme port."
 'dark
 'modern-catppuccin-frappe-palette
 nil
 'modern-catppuccin-frappe-palette-overrides
 'modern-catppuccin-frappe-custom-faces)

(provide 'modern-catppuccin-frappe-theme)
;;; modern-catppuccin-frappe-theme.el ends here
