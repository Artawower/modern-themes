;;; modern-github-light-theme.el --- GitHub Light theme port -*- lexical-binding:t -*-

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
;; The `modern-github-light' theme is a port of the GitHub Light theme
;; to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-github-light-palette-partial
  '((cursor "#24292f")
    (bg-main "#ffffff")
    (bg-dim "#f6f8fa")
    (bg-alt "#eaeef2")
    (fg-main "#24292f")
    (fg-dim "#57606a")
    (fg-alt "#57606a")
    (bg-active "#afb8c1")
    (bg-inactive "#eaeef2")
    (border "#d0d7de")

    (red           "#cf222e")
    (red-warmer    "#b71b29")
    (red-cooler    "#e13a44")
    (red-faint     "#fcd6d6")

    (green         "#1a7f37")
    (green-warmer  "#2b8f3f")
    (green-cooler  "#1a7f68")
    (green-faint   "#dafbe1")

    (yellow        "#9a6700")
    (yellow-warmer "#b57a00")
    (yellow-cooler "#7c5400")
    (yellow-faint  "#fff3b8")

    (blue          "#0969da")
    (blue-warmer   "#218bff")
    (blue-cooler   "#0550ae")
    (blue-faint    "#dbeeff")

    (magenta       "#8250df")
    (magenta-warmer "#a475f9")
    (magenta-cooler "#6f46c4")
    (magenta-faint  "#f2e7ff")

    (cyan          "#1b7c83")
    (cyan-warmer   "#25929a")
    (cyan-cooler   "#12707a")
    (cyan-faint    "#dff6f9")

    (bg-red-intense "#ffebe9")
    (bg-green-intense "#dafbe1")
    (bg-yellow-intense "#fff8c5")
    (bg-blue-intense "#ddf4ff")
    (bg-magenta-intense "#fbefff")
    (bg-cyan-intense "#ddf4ff")

    (bg-red-subtle "#fff5f5")
    (bg-green-subtle "#f0fff4")
    (bg-yellow-subtle "#fffdf5")
    (bg-blue-subtle "#f0f8ff")
    (bg-magenta-subtle "#fcf5ff")
    (bg-cyan-subtle "#f0f8ff")

    (bg-added         "#dafbe1")
    (bg-added-faint   "#f0fff4")
    (bg-added-refine  "#b3e6c2")
    (fg-added         "#1a7f37")

    (bg-changed        "#fff8c5")
    (bg-changed-faint  "#fffdf5")
    (bg-changed-refine "#e6d48f")
    (fg-changed        "#9a6700")

    (bg-removed        "#ffebe9")
    (bg-removed-faint  "#fff5f5")
    (bg-removed-refine "#f4b3af")
    (fg-removed        "#cf222e")

    (bg-mode-line-active-col "#f6f8fa")
    (bg-hover-col "#ececec")
    (bg-hover-secondary-col "#f6f8fa")
    (bg-paren-match-col "#d0d7de")))

(defconst modern-github-light-palette-common
  '((fringe unspecified)
    (fg-region unspecified)
    (bg-diff-context bg-dim)
    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-dim)))

(defconst modern-github-light-palette-mappings-partial
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

(defcustom modern-github-light-palette-overrides nil
  "Overrides for `modern-github-light-palette'."
  :group 'modern-themes
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-github-light-palette
  (modus-themes-generate-palette
   modern-github-light-palette-partial
   nil
   nil
   (append modern-github-light-palette-mappings-partial modern-github-light-palette-common)))

(defconst modern-github-light-custom-faces
  nil)

(modus-themes-theme
 'modern-github-light
 'modern-github-light
 "GitHub Light theme port."
 'light
 'modern-github-light-palette
 nil
 'modern-github-light-palette-overrides
 'modern-github-light-custom-faces)

(provide 'modern-github-light-theme)

;;; modern-github-light-theme.el ends here
