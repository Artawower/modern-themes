;;; modern-quiet-light-theme.el --- Catppuccin Latte theme port -*- lexical-binding:t -*-

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
;; The `modern-quiet-light' theme is a port of the VS Code Quiet Light theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)


(defconst modern-quiet-light-palette-partial
  '(
    
    (cursor "#5E497F")
    (bg-main "#F5F5F5")
    (bg-dim  "#EFEFEF")
    (bg-alt  "#E5E4FA")
    (fg-main "#7A3E9D")
    (fg-dim  "#8E8E90")
    (fg-alt  "#505050")
    (bg-active "#E4E4E4")
    (bg-inactive "#F7F7F7")
    (border "#D0D0D0")

    
    (red           "#A31515")
    (red-warmer    "#C43333")
    (red-cooler    "#8C0F0F")
    (red-faint     "#B86A6A")

    (green         "#036D2F")
    (green-warmer  "#0A8F48")
    (green-cooler  "#025724")
    (green-faint   "#6BAF8A")

    (yellow        "#B89500")
    (yellow-warmer "#D8AC00")
    (yellow-cooler "#9C7F00")
    (yellow-faint  "#D6C27A")

    (blue          "#4B69C6")
    (blue-warmer   "#5C7BE0")
    (blue-cooler   "#3C57A8")
    (blue-faint    "#90A4E0")

    (magenta        "#646695") 
    (magenta-warmer "#7A7CC0")
    (magenta-cooler "#4D4E78")
    (magenta-faint  "#A6A7CC")

    (cyan          "#267f99") 
    (cyan-warmer   "#3A9AB4")
    (cyan-cooler   "#1C5E73")
    (cyan-faint    "#82B7C3")

    (teal "#267f99")

    
    (bg-red-intense "#F6D3D3")
    (bg-green-intense "#D9EED8")
    (bg-yellow-intense "#F4EDC7")
    (bg-blue-intense "#DDE6FF")
    (bg-magenta-intense "#E5E4FA")
    (bg-cyan-intense "#D7EEF2")

    (bg-red-subtle "#F1E0E0")
    (bg-green-subtle "#E4F3E1")
    (bg-yellow-subtle "#F8F3DE")
    (bg-blue-subtle "#EBF0FF")
    (bg-magenta-subtle "#EFEFFE")
    (bg-cyan-subtle "#E6F4F6")

    
    (bg-added         "#E4F3E1")
    (bg-added-faint   "#EEF8EB")
    (bg-added-refine  "#CFE8C7")
    (fg-added         "#036D2F")

    (bg-changed        "#F8F3DE")
    (bg-changed-faint  "#FAF7EB")
    (bg-changed-refine "#EADFB2")
    (fg-changed        "#7A5A00")

    (bg-removed        "#F1E0E0")
    (bg-removed-faint  "#F8EAEA")
    (bg-removed-refine "#E6C7C7")
    (fg-removed        "#8A1A1A")

    
    (fg-heading-0-col "#646695")
    (fg-heading-1-col "#0000FF")
    (fg-heading-2-col "#267f99")
    (fg-heading-3-col "#036D2F")
    (fg-heading-4-col "#A31515")
    (fg-heading-5-col "#B89500")
    (fg-heading-6-col "#7A7CC0")
    (fg-heading-7-col "#3750F0")
    (fg-heading-8-col "#4D4E78")
    ))

(defconst modern-quiet-light-palette-common
  '(
    (fringe unspecified)
    (fg-region unspecified)

    (bg-diff-context bg-dim)

    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-active)

    (fg-link-symbolic blue)
    (underline-link border)
    (underline-link-symbolic border)

    (border-mode-line-active border)
    (bg-mode-line-inactive bg-alt)
    (fg-mode-line-inactive fg-dim)
    (bg-mode-line-active red)
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
    (fg-heading-8 rainbow-8)
    ))

(defconst modern-quiet-light-palette-mappings-partial
  '(
    (err red)
    (warning yellow)
    (info blue)

    (fg-mode-line-active fg-main)
    (bg-completion bg-alt)
    (bg-hl-line bg-dim)

    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-alt)

    
    (comment fg-dim)
    (string green)
    (builtin red-warmer)
    (constant yellow)
    (type cyan-warmer)
    (variable fg-main)
    (variable-use fg-main)
    (fnname red)
    (fnname-call red)
    (property magenta-warmer)
    (keyword blue)
    (preprocessor red-faint)
    (docstring fg-dim)
    (rx-backslash magenta)
    (rx-construct red)

    
    (rainbow-0 fg-heading-0-col)
    (rainbow-1 fg-heading-1-col)
    (rainbow-2 fg-heading-2-col)
    (rainbow-3 fg-heading-3-col)
    (rainbow-4 fg-heading-4-col)
    (rainbow-5 fg-heading-5-col)
    (rainbow-6 fg-heading-6-col)
    (rainbow-7 fg-heading-7-col)
    (rainbow-8 fg-heading-8-col)
    ))

(defcustom modern-quiet-light-palette-overrides nil
  "Overrides for `modern-quiet-light-palette'."
  :group 'modern-quiet-light
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-quiet-light-palette
  (modus-themes-generate-palette
   modern-quiet-light-palette-partial
   nil nil
   (append modern-quiet-light-palette-mappings-partial
           modern-quiet-light-palette-common)))

(modus-themes-theme
 'modern-quiet-light
 'modern-quiet-light
 "Quiet Light theme port."
 'light
 'modern-quiet-light-palette
 nil
 'modern-quiet-light-palette-overrides
 nil)

(provide 'modern-quiet-light-theme)


