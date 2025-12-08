;;; modern-catppuccin-macchiato-theme.el --- Catppuccin Macchiato theme port -*- lexical-binding:t -*-

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
;; The `modern-catppuccin-macchiato' theme is a port of the Catppuccin Macchiato theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-catppuccin-macchiato-palette-partial
  '((cursor "#f4dbd6")
    (bg-main "#24273a")
    (bg-dim "#181926")
    (bg-alt "#363a4f")
    (fg-main "#cad3f5")
    (fg-dim "#a5adcb")
    (fg-alt "#b8c0e0")
    (bg-active "#5b6078")
    (bg-inactive "#1e2030")
    (border "#6e738d")

    (red "#ed8796")
    (red-warmer "#ee99a0")
    (red-cooler "#f0c6c6")
    (red-faint "#be5867")
    (green "#a6da95")
    (green-warmer "#a6da95")
    (green-cooler "#8bd5ca")
    (green-faint "#78ab67")
    (yellow "#eed49f")
    (yellow-warmer "#f5a97f")
    (yellow-cooler "#eed49f")
    (yellow-faint "#c1a468")
    (blue "#8aadf4")
    (blue-warmer "#7dc4e4")
    (blue-cooler "#b7bdf8")
    (blue-faint "#577cc6")
    (magenta "#c6a0f6")
    (magenta-warmer "#f5bde6")
    (magenta-cooler "#c6a0f6")
    (magenta-faint "#9265cb")
    (cyan "#91d7e3")
    (cyan-warmer "#8bd5ca")
    (cyan-cooler "#7dc4e4")
    (cyan-faint "#62a8b4")
    (teal "#8bd5ca")

    (bg-red-intense "#604355")
    (bg-green-intense "#4b5c55")
    (bg-yellow-intense "#605a58")
    (bg-blue-intense "#424f71")
    (bg-magenta-intense "#544b72")
    (bg-cyan-intense "#445b6c")

    (bg-red-subtle "#423547")
    (bg-green-subtle "#374147")
    (bg-yellow-subtle "#424049")
    (bg-blue-subtle "#333b55")
    (bg-magenta-subtle "#3c3956")
    (bg-cyan-subtle "#344153")

    (bg-added         "#494d64")
    (bg-added-faint   "#363a4f")
    (bg-added-refine  "#5e7a55")
    (fg-added         "#a6da95")

    (bg-changed        "#494d64")
    (bg-changed-faint  "#363a4f")
    (bg-changed-refine "#7f6a45")
    (fg-changed        "#eed49f")

    (bg-removed        "#494d64")
    (bg-removed-faint  "#363a4f")
    (bg-removed-refine "#8f5058")
    (fg-removed        "#ed8796")

    ;; Unique colors needed for mappings
    (bg-mode-line-active-col "#494d64") ;; Surface1
    (bg-hover-col "#5b6078") ;; Surface2
    (bg-hover-secondary-col "#494d64") ;; Surface1
    (bg-paren-match-col "#6e738d") ;; Overlay0
    (fg-heading-0-col "#ed8796") ;; Red
    (fg-heading-1-col "#f5a97f") ;; Peach
    (fg-heading-2-col "#eed49f") ;; Yellow
    (fg-heading-3-col "#a6da95") ;; Green
    (fg-heading-4-col "#7dc4e4") ;; Sapphire
    (fg-heading-5-col "#8aadf4") ;; Blue
    (fg-heading-6-col "#b7bdf8") ;; Lavender
    (fg-heading-7-col "#c6a0f6") ;; Mauve
    (fg-heading-8-col "#f5bde6"))) ;; Pink

(defconst modern-catppuccin-macchiato-palette-common
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

(defconst modern-catppuccin-macchiato-palette-mappings-partial
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

(defcustom modern-catppuccin-macchiato-palette-overrides nil
  "Overrides for `modern-catppuccin-macchiato-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

To preview the palette entries, use `modus-themes-preview-colors' or
`modus-themes-preview-colors-current' (read the documentation for
further details)."
  :group 'modern-catppuccin-macchiato
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-catppuccin-macchiato-palette
  (modus-themes-generate-palette
   modern-catppuccin-macchiato-palette-partial
   nil
   nil
   (append modern-catppuccin-macchiato-palette-mappings-partial modern-catppuccin-macchiato-palette-common)))

(defconst modern-catppuccin-macchiato-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-catppuccin-macchiato
 'modern-catppuccin-macchiato
 "Catppuccin Macchiato theme port."
 'dark
 'modern-catppuccin-macchiato-palette
 nil
 'modern-catppuccin-macchiato-palette-overrides
 'modern-catppuccin-macchiato-custom-faces)

(provide 'modern-catppuccin-macchiato-theme)
;;; modern-catppuccin-macchiato-theme.el ends here
