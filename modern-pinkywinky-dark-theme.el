;;; modern-pinkywinky-dark-theme.el --- Legible dark theme inspired by Pinky Winky -*- lexical-binding:t -*-

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
;; The `modern-pinkywinky-dark' theme is a port of the Pinky Winky Dark theme
;; to the `modus-themes' structure.

;;; Code:

;;; modern-pinkywinky-dark-theme.el --- Pinky Winky Dark port -*- lexical-binding:t -*-

(require 'modus-themes)

(defconst modern-pinkywinky-dark-palette-partial
  '((cursor "#00AEE8")

    (bg-main      "#24283b")
    (bg-dim       "#1f2335")
    (bg-alt       "#1f2335")
    (fg-main      "#c0caf5")
    (fg-dim       "#a9b1d6")
    (fg-alt       "#a9b1d6")
    (bg-active    "#3f444a")
    (bg-inactive  "#24283b")
    (border       "#5b6268")

    (red           "#FEAFE0")
    (red-warmer    "#FF96CC")
    (red-cooler    "#EA97F0")
    (red-faint     "#c24552")

    (green         "#8bcd5b")
    (green-warmer  "#4a7d00")
    (green-cooler  "#007f68")
    (green-faint   "#61756c")

    (yellow        "#ECBE7B")
    (yellow-warmer "#b6532f")
    (yellow-cooler "#b65050")
    (yellow-faint  "#9a5f6a")

    (blue          "#4FC3F7")
    (blue-warmer   "#5250ef")
    (blue-cooler   "#065fff")
    (blue-faint    "#6060d0")

    (magenta        "#ee7ae9")
    (magenta-warmer "#E4CCFF")
    (magenta-cooler "#8e44f3")
    (magenta-faint  "#a45392")

    (cyan        "#00CED1")
    (cyan-warmer "#3f6faf")
    (cyan-cooler "#0f7b8f")
    (cyan-faint  "#5f60bf")

    (teal "#4db5bd")

    ;; Diff (dark, readable)
    (bg-added         "#1e3524")
    (bg-added-faint   "#162a1c")
    (bg-added-refine  "#2b4a33")
    (fg-added         "#8bcd5b")

    (bg-changed        "#3a2f1e")
    (bg-changed-faint  "#2a2316")
    (bg-changed-refine "#4b3d27")
    (fg-changed        "#ECBE7B")

    (bg-removed        "#3b1f2a")
    (bg-removed-faint  "#2a1620")
    (bg-removed-refine "#512a38")
    (fg-removed        "#FEAFE0")
    ))

(defconst modern-pinkywinky-dark-palette-common
  '((fringe unspecified)
    (fg-region unspecified)

    ;; Diff defaults for Modus
    (bg-diff-context bg-dim)
    (bg-diff-focus   bg-alt)
    (bg-diff-text    bg-active)

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

    ;; Search
    (fg-search-current fg-main)
    (fg-search-lazy fg-main)
    (fg-search-static fg-main)
    (fg-search-replace fg-main)

    (fg-search-rx-group-0 fg-main)
    (fg-search-rx-group-1 fg-main)
    (fg-search-rx-group-2 fg-main)
    (fg-search-rx-group-3 fg-main)

    ;; Completion
    (fg-completion-match-0 accent-0)
    (fg-completion-match-1 accent-1)
    (fg-completion-match-2 accent-2)
    (fg-completion-match-3 accent-3)

    ;; Headings rainbow
    (fg-heading-0 rainbow-0)
    (fg-heading-1 rainbow-1)
    (fg-heading-2 rainbow-2)
    (fg-heading-3 rainbow-3)
    (fg-heading-4 rainbow-4)
    (fg-heading-5 rainbow-5)
    (fg-heading-6 rainbow-6)
    (fg-heading-7 rainbow-7)
    (fg-heading-8 rainbow-8)))

(defconst modern-pinkywinky-dark-palette-mappings-partial
  '((err red-warmer)
    (warning yellow)
    (info green-cooler)

    (bg-mode-line-active bg-active)
    (fg-mode-line-active fg-main)

    (bg-completion magenta-faint)
    (bg-hover bg-alt)
    (bg-hover-secondary bg-active)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-active)

    ;; Syntax
    (comment fg-dim)
    (string magenta-warmer)
    (builtin blue)
    (constant fg-main)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta)
    (preprocessor blue)
    (docstring fg-dim)
    (type magenta-warmer)
    (variable fg-main)
    (variable-use fg-main)
    (property fg-main)
    (rx-backslash cyan-cooler)
    (rx-construct red-cooler)

    ;; Rainbow headings
    (rainbow-0 magenta-warmer)
    (rainbow-1 magenta-cooler)
    (rainbow-2 yellow)
    (rainbow-3 cyan)
    (rainbow-4 magenta)
    (rainbow-5 blue-warmer)
    (rainbow-6 red-cooler)
    (rainbow-7 cyan-cooler)
    (rainbow-8 yellow-cooler)))

(defcustom modern-pinkywinky-dark-palette-overrides nil
  "Overrides for `modern-pinkywinky-dark-palette'."
  :group 'modern-pinkywinky-dark
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-pinkywinky-dark-palette
  (modus-themes-generate-palette
   modern-pinkywinky-dark-palette-partial
   nil nil
   (append modern-pinkywinky-dark-palette-mappings-partial
           modern-pinkywinky-dark-palette-common)))

(defconst modern-pinkywinky-dark-custom-faces
  '(`(magit-section-highlight ((,c :background ,bg-alt)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))))

(modus-themes-theme
 'modern-pinkywinky-dark
 'modern-pinkywinky-dark
 "Pinky Winky Dark theme."
 'dark
 'modern-pinkywinky-dark-palette
 nil
 'modern-pinkywinky-dark-palette-overrides
 'modern-pinkywinky-dark-custom-faces)

(provide 'modern-pinkywinky-dark-theme)

;;; modern-pinkywinky-dark-theme.el ends here
