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
    ;; Base
    (bg-main     "#2E3440")
    (bg-dim      "#242832")
    (bg-alt      "#242832")
    (fg-main     "#ECEFF4")
    (fg-dim      "#677691")
    (fg-alt      "#677691")
    (bg-active   "#3B4252")
    (bg-inactive "#2E3440")
    (border      "#3B4252")

    ;; Accents (Nano-style minimal palette)
    (red           "#D08770")
    (red-warmer    "#E06C75")
    (red-cooler    "#EF5350")
    (red-faint     "#8c3f3f")

    (green         "#A3BE8C")
    (green-warmer  "#8FBC8F")
    (green-cooler  "#66BB6A")
    (green-faint   "#49634a")

    (yellow         "#EBCB8B")
    (yellow-warmer  "#FFEE58")
    (yellow-cooler  "#D08770")
    (yellow-faint   "#7a673f")

    (blue           "#81A1C1")
    (blue-warmer    "#A4C8F0")
    (blue-cooler    "#5E81AC")
    (blue-faint     "#4a6075")

    (magenta        "#B48EAD")
    (magenta-warmer "#C07ECF")
    (magenta-cooler "#8F6F99")
    (magenta-faint  "#6f5970")

    (cyan           "#88C0D0")
    (cyan-warmer    "#9FD9E8")
    (cyan-cooler    "#5E81AC")
    (cyan-faint     "#4a6a75")

    ;; Diff — darker, subtle, Nano-consistent
    (bg-added         "#1f3325")
    (bg-added-faint   "#18271d")
    (bg-added-refine  "#2b4a33")
    (fg-added         "#A3BE8C")

    (bg-changed        "#332c1f")
    (bg-changed-faint  "#272117")
    (bg-changed-refine "#4b3d27")
    (fg-changed        "#EBCB8B")

    (bg-removed        "#331f25")
    (bg-removed-faint  "#27171d")
    (bg-removed-refine "#4a2b33")
    (fg-removed        "#D08770")

    ;; Region
    (bg-region "#434C5E")
    ))

(defconst modern-nano-dark-palette-common
  '((fringe unspecified)
    (fg-region unspecified)

    ;; Diff defaults
    (bg-diff-context bg-dim)
    (bg-diff-focus bg-alt)
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
    (info blue-cooler)

    (bg-mode-line-active bg-active)
    (fg-mode-line-active fg-main)

    (bg-completion bg-dim)
    (bg-hover bg-active)
    (bg-hover-secondary bg-active)
    (bg-hl-line bg-active)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-region)

    ;; Syntax (monochrome + small accents)
    (comment fg-dim)
    (string fg-dim)
    (builtin blue-cooler)
    (constant fg-main)
    (fnname fg-main)
    (fnname-call fg-main)
    (keyword blue-cooler)
    (preprocessor blue-cooler)
    (docstring fg-dim)
    (type blue-cooler)
    (variable fg-main)
    (variable-use fg-main)
    (property fg-main)
    (rx-backslash blue-cooler)
    (rx-construct blue-cooler)

    ;; Minimal accents everywhere
    (accent-0 fg-main)
    (accent-1 fg-main)
    (accent-2 fg-main)
    (accent-3 fg-main)

    ;; Date & prose
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

    ;; Mail
    (mail-cite-0 yellow)
    (mail-cite-1 magenta)
    (mail-cite-2 blue)
    (mail-cite-3 cyan)
    (mail-part magenta-faint)
    (mail-recipient magenta)
    (mail-subject magenta)
    (mail-other magenta)

    ;; Search
    (bg-search-static bg-warning)
    (bg-search-current bg-yellow-intense)
    (bg-search-lazy bg-blue-intense)
    (bg-search-replace bg-red-intense)

    ;; Rainbow headings – monochrome
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
Each entry should be of the form (NAME VALUE) where NAME is a
palette symbol and VALUE is either another symbol or a string
representing a color.  These values replace entries in the
computed palette."
  :group 'modern-nano-dark
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-nano-dark-palette
  (modus-themes-generate-palette
   modern-nano-dark-palette-partial
   nil nil
   (append modern-nano-dark-palette-mappings-partial
           modern-nano-dark-palette-common)))

(defconst modern-nano-dark-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight
      ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

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
