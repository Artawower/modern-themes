;;; modern-github-dark-theme.el --- Github Dark theme port -*- lexical-binding:t -*-

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
;; The `modern-github-dark' theme is a port of the github dark theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-github-dark-palette-partial
  '((cursor "#f0f6fc")
    (bg-main "#0d1117")
    (bg-dim "#161b22")
    (bg-alt "#21262d")
    (fg-main "#c9d1d9")
    (fg-dim "#8b949e")
    (fg-alt "#8b949e")
    (bg-active "#30363d")
    (bg-inactive "#0d1117")
    (border "#30363d")

    (red           "#ff7b72")
    (red-warmer    "#ff948e")
    (red-cooler    "#ff968c")
    (red-faint     "#b35c5a")

    (green         "#3fb950")
    (green-warmer  "#48c164")
    (green-cooler  "#30a86a")
    (green-faint   "#2e7a42")

    (yellow        "#d29922")
    (yellow-warmer "#e0a73b")
    (yellow-cooler "#b8891e")
    (yellow-faint  "#7a5f18")

    (blue          "#58a6ff")
    (blue-warmer   "#7db7ff")
    (blue-cooler   "#3c8de6")
    (blue-faint    "#1e4f8a")

    (magenta       "#bc8cff")
    (magenta-warmer "#d2a3ff")
    (magenta-cooler "#a571f0")
    (magenta-faint  "#6b4aa0")

    (cyan          "#39c5cf")
    (cyan-warmer   "#5ed9df")
    (cyan-cooler   "#2aa5b1")
    (cyan-faint    "#1c6670")

    (bg-red-intense    "#490202")
    (bg-green-intense  "#0f5323")
    (bg-yellow-intense "#5a3a00")
    (bg-blue-intense   "#053975")
    (bg-magenta-intense "#4e2996")
    (bg-cyan-intense   "#0d3f48")

    (bg-red-subtle     "#340c0c")
    (bg-green-subtle   "#0a2614")
    (bg-yellow-subtle  "#2b1d00")
    (bg-blue-subtle    "#031d38")
    (bg-magenta-subtle "#26154a")
    (bg-cyan-subtle    "#072025")

    (bg-added         "#30363d")
    (bg-added-faint   "#161b22")
    (bg-added-refine  "#2d5630")
    (fg-added         "#3fb950")

    (bg-changed        "#30363d")
    (bg-changed-faint  "#161b22")
    (bg-changed-refine "#7a5e28")
    (fg-changed        "#d29922")

    (bg-removed        "#30363d")
    (bg-removed-faint  "#161b22")
    (bg-removed-refine "#6f2c34")
    (fg-removed        "#ff7b72")

    (bg-mode-line-active-col "#161b22")
    (bg-hover-col "#21262d")
    (bg-hover-secondary-col "#161b22")
    (bg-paren-match-col "#30363d")))

(defconst modern-github-dark-palette-common
  '((fringe unspecified)
    (fg-region unspecified)
    (bg-diff-context bg-dim)
    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-dim)))

(defconst modern-github-dark-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active bg-mode-line-active-col)
    (fg-mode-line-active fg-main)

    (bg-completion bg-dim)
    (bg-hover bg-hover-col)
    (bg-hover-secondary bg-hover-secondary-col)
    (bg-hl-line bg-dim)
    (bg-paren-match bg-main)
    (bg-region bg-active)

    (fg-link blue)
    (fg-link-visited blue-cooler)

    (builtin red)
    (comment fg-dim)
    (constant blue)
    (fnname magenta)
    (keyword red)
    (preprocessor red)
    (docstring fg-dim)
    (string blue-cooler)
    (type red)
    (variable fg-main)

    (bg-added          bg-added)
    (bg-added-faint    bg-added-faint)
    (bg-added-refine   bg-added-refine)
    (fg-added          fg-added)

    (bg-changed        bg-changed)
    (bg-changed-faint  bg-changed-faint)
    (bg-changed-refine bg-changed-refine)
    (fg-changed        fg-changed)

    (bg-removed        bg-removed)
    (bg-removed-faint  bg-removed-faint)
    (bg-removed-refine bg-removed-refine)
    (fg-removed        fg-removed)

    (bg-search-current yellow)
    (bg-search-lazy    blue)
    (bg-search-replace red)
    (bg-search-static  bg-active)

    (bg-search-rx-group-0 magenta)
    (bg-search-rx-group-1 green)
    (bg-search-rx-group-2 red)
    (bg-search-rx-group-3 cyan)

    (fg-search-current fg-main)
    (fg-search-lazy    fg-main)
    (fg-search-replace fg-main)
    (fg-search-static  fg-main)

    (rainbow-0 red)
    (rainbow-1 yellow)
    (rainbow-2 blue)
    (rainbow-3 magenta)
    (rainbow-4 cyan)
    (rainbow-5 green)
    (rainbow-6 red-warmer)
    (rainbow-7 blue-warmer)
    (rainbow-8 magenta-warmer)))

(defcustom modern-github-dark-palette-overrides nil
  "Overrides for `modern-github-dark-palette'.
Mirror the structure of the palette, just like the `modus-themes' do."
  :group 'modern-themes
  :type '(repeat (list symbol (choice symbol string))))


(defconst modern-github-dark-palette
  (modus-themes-generate-palette
   modern-github-dark-palette-partial
   nil
   nil
   (append modern-github-dark-palette-mappings-partial modern-github-dark-palette-common)))

(defconst modern-github-dark-custom-faces
  nil)

(modus-themes-theme
 'modern-github-dark
 'modern-github-dark
 "GitHub Dark theme port."
 'dark
 'modern-github-dark-palette
 nil
 'modern-github-dark-palette-overrides
 'modern-github-dark-custom-faces)

(provide 'modern-github-dark-theme)
