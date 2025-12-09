;;; modern-nightfly-purple-theme.el --- Nightfly Purple Electric port -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation, Inc.

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

;;; Commentary:
;;
;; The `modern-nightfly-purple' theme is a high-contrast electric-purple
;; variant inspired by Fluoromachine & Nightfly, implemented using the
;; `modus-themes' palette structure.

;;; Code:

(require 'modus-themes)

(defconst modern-nightfly-purple-palette-partial
  '((cursor "#ffd45a")

    ;; Core backgrounds
    (bg-main      "#200933")
    (bg-dim       "#0e061a")
    (bg-alt       "#1a0f2e")
    (bg-active    "#2a1a44")
    (bg-inactive  "#120824")
    (border       "#3e2a63")

    ;; Foregrounds
    (fg-main "#e1d9ff")
    (fg-dim  "#aa9ccc")
    (fg-alt  "#b29ce0")

    ;; Base colors (electric / neon)
    (red            "#ff4f6e")
    (red-warmer     "#ff6f8a")
    (red-cooler     "#e03b5b")
    (red-faint      "#c74963")

    (green          "#8aff7a")
    (green-warmer   "#9cff8f")
    (green-cooler   "#6fdc62")
    (green-faint    "#5ca856")

    (yellow         "#FFCC02")
    (yellow-warmer  "#ffdf7a")
    (yellow-cooler  "#e6c14f")
    (yellow-faint   "#c7a44a")

    (blue           "#5ecbff")
    (blue-warmer    "#7ad8ff")
    (blue-cooler    "#3aa7e0")
    (blue-faint     "#2c82b3")

    (magenta        "#d46bff")
    (magenta-warmer "#e28aff")
    (magenta-cooler "#c155ff")
    (magenta-faint  "#a45cd1")

    (cyan           "#5dfdff")
    (cyan-warmer    "#7cffff")
    (cyan-cooler    "#3ad8e0")
    (cyan-faint     "#49aeb3")

    ;; Subtle backgrounds
    (bg-red-intense     "#3a0a14")
    (bg-green-intense   "#0b260f")
    (bg-yellow-intense  "#332200")
    (bg-blue-intense    "#071526")
    (bg-magenta-intense "#1c0829")
    (bg-cyan-intense    "#072327")

    (bg-red-subtle      "#2b0a12")
    (bg-green-subtle    "#0a1c10")
    (bg-yellow-subtle   "#2b200b")
    (bg-blue-subtle     "#0c1724")
    (bg-magenta-subtle  "#1a1030")
    (bg-cyan-subtle     "#0b1f22")

    ;; Diff colors
    (bg-added         "#0f2a19")
    (bg-added-faint   "#0a1e12")
    (bg-added-refine  "#184f2d")
    (fg-added         "#8aff7a")

    (bg-changed        "#2d240f")
    (bg-changed-faint  "#1e190c")
    (bg-changed-refine "#5a441f")
    (fg-changed        "#ffd45a")

    (bg-removed        "#2d0f18")
    (bg-removed-faint  "#1c0a10")
    (bg-removed-refine "#5a1f31")
    (fg-removed        "#ff4f6e")))

(defconst modern-nightfly-purple-palette-common
  '((fringe unspecified)
    (fg-region unspecified)

    (bg-diff-context bg-dim)

    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-active)

    (border-mode-line-active border)
    (bg-mode-line-inactive bg-alt)
    (fg-mode-line-inactive fg-dim)
    (border-mode-line-inactive border)

    (bg-line-number-active bg-active)
    (fg-line-number-active fg-main)
    (bg-line-number-inactive bg-dim)

    (bg-space unspecified)
    (fg-space border)))

(defconst modern-nightfly-purple-palette-mappings-partial
  '((err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active bg-active)
    (fg-mode-line-active fg-main)

    (bg-hover bg-active)
    (bg-completion bg-active)
    (bg-hover-secondary bg-alt)
    (bg-hl-line bg-alt)
    (bg-paren-match bg-main)
    (bg-region bg-active)

    ;; Syntax
    (builtin magenta)
    (comment fg-dim)
    (constant blue)
    (fnname cyan)
    (fnname-call cyan)
    (keyword magenta)
    (preprocessor magenta-warmer)
    (docstring fg-dim)
    (string green)
    (type yellow)
    (variable fg-main)
    (variable-use fg-main)
    (rx-backslash cyan)
    (rx-construct magenta)

    ;; Accents
    (accent-0 magenta)
    (accent-1 yellow)
    (accent-2 blue)
    (accent-3 red)

    ;; Rainbow delimiters
    (rainbow-0 magenta)
    (rainbow-1 yellow)
    (rainbow-2 cyan)
    (rainbow-3 blue)
    (rainbow-4 green)
    (rainbow-5 magenta-warmer)
    (rainbow-6 yellow-warmer)
    (rainbow-7 cyan-cooler)
    (rainbow-8 blue-cooler)

    ;; Search
    (bg-search-current yellow)
    (fg-search-current bg-main)
    (bg-search-lazy blue)
    (fg-search-lazy bg-main)
    (bg-search-replace red)
    (fg-search-replace bg-main)
    (bg-search-static bg-active)))

(defcustom modern-nightfly-purple-palette-overrides nil
  "Overrides for `modern-nightfly-purple-palette'."
  :group 'modern-themes
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-nightfly-purple-palette
  (modus-themes-generate-palette
   modern-nightfly-purple-palette-partial
   nil
   nil
   (append modern-nightfly-purple-palette-mappings-partial
           modern-nightfly-purple-palette-common)))

(defconst modern-nightfly-purple-custom-faces
  nil)

(modus-themes-theme
 'modern-nightfly-purple
 'modern-nightfly-purple
 "Nightfly Purple Electric theme port."
 'dark
 'modern-nightfly-purple-palette
 nil
 'modern-nightfly-purple-palette-overrides
 'modern-nightfly-purple-custom-faces)

(provide 'modern-nightfly-purple-theme)

;;; modern-nightfly-purple-theme.el ends here
