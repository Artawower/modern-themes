;;; modern-ayu-mirage-theme.el --- Ayu Mirage theme port -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software...

;;; Commentary:
;;
;; The `modern-ayu-mirage' theme is a port of the Ayu Mirage color scheme
;; to the `modus-themes' structure.

;;; Code:

;;; modern-ayu-mirage-theme.el --- Ayu Mirage theme port -*- lexical-binding:t -*-

(require 'modus-themes)

(defconst modern-ayu-mirage-palette-partial
  '(
    
    (cursor "#FFCC66")
    (bg-main "#242936")
    (bg-dim  "#1F2430")
    (bg-alt  "#1A1F29")
    (fg-main "#CCCAC2")
    (fg-dim  "#707A8C")
    (fg-alt  "#FFAD66")
    (bg-active "#353C4C")
    (bg-inactive "#1F2430")
    (border      "#171B24")

    
    (red           "#FF6666")
    (red-warmer    "#FF7A7A")
    (red-cooler    "#E65C5C")
    (red-faint     "#CC5252")

    (green         "#87D96C")
    (green-warmer  "#9FE67C")
    (green-cooler  "#7DD96C")
    (green-faint   "#6CC95C")

    (yellow        "#FFCC66")
    (yellow-warmer "#FFD476")
    (yellow-cooler "#FFBF56")
    (yellow-faint  "#E6B256")

    (blue          "#73D0FF")
    (blue-warmer   "#80D6FF")
    (blue-cooler   "#66C8FF")
    (blue-faint    "#52B8FF")

    (magenta        "#DFBFFF")
    (magenta-warmer "#E8C5FF")
    (magenta-cooler "#D6B5FF")
    (magenta-faint  "#C5A5FF")

    (cyan         "#5CCFE6")
    (cyan-warmer  "#6DD5EC")
    (cyan-cooler  "#4FC9E0")
    (cyan-faint   "#3FC3DA")

    
    (bg-added         "#1A2E1F")
    (bg-added-faint   "#152A1A")
    (bg-added-refine  "#204028")
    (fg-added         "#87D96C")

    (bg-changed        "#1A2430")
    (bg-changed-faint  "#141E28")
    (bg-changed-refine "#1F2A38")
    (fg-changed        "#80BFFF")

    (bg-removed        "#2E1A1A")
    (bg-removed-faint  "#251515")
    (bg-removed-refine "#3A2020")
    (fg-removed        "#F27983")

    
    (bg-red-intense     "#331A1A")
    (bg-green-intense   "#1A2E1A")
    (bg-yellow-intense  "#2E281A")
    (bg-blue-intense    "#1A2433")
    (bg-magenta-intense "#2A1A33")
    (bg-cyan-intense    "#1A2A2E")

    (bg-red-subtle     "#2A1515")
    (bg-green-subtle   "#152A15")
    (bg-yellow-subtle  "#282215")
    (bg-blue-subtle    "#152033")
    (bg-magenta-subtle "#251533")
    (bg-cyan-subtle    "#152528")))

(defconst modern-ayu-mirage-palette-common
  '((fringe unspecified)
    (fg-region unspecified)
    (bg-diff-context bg-dim)

    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-active)

    (fg-link-symbolic blue)
    (underline-link border)

    (border-mode-line-active border)
    (bg-mode-line-inactive bg-alt)
    (fg-mode-line-inactive fg-dim)

    (bg-line-number-active bg-alt)
    (fg-line-number-active fg-alt)))

(defconst modern-ayu-mirage-palette-mappings-partial
  '(
    (err red)
    (warning yellow)
    (info blue)

    (bg-mode-line-active bg-active)
    (fg-mode-line-active fg-alt)

    (bg-completion bg-alt)
    (bg-hover bg-alt)
    (bg-hover-secondary bg-active)
    (bg-paren-match bg-main)
    (bg-err bg-main)
    (bg-warning bg-main)
    (bg-info bg-main)
    (bg-region bg-active)

    (builtin green)
    (comment fg-dim)
    (constant red)
    (fnname magenta)
    (fnname-call magenta)
    (keyword fg-alt)   
    (preprocessor green)
    (docstring cyan)
    (string cyan)
    (type yellow-warmer)
    (variable fg-main)
    (property fg-main)
    (variable-use fg-main)
    (rx-backslash magenta)
    (rx-construct red)

    (fg-term-black fg-main)

    (bg-mark-delete bg-err)
    (fg-mark-delete err)
    (bg-mark-select bg-info)
    (fg-mark-select info)
    (bg-mark-other bg-warning)
    (fg-mark-other warning)



    (rainbow-0 magenta)
    (rainbow-1 red)
    (rainbow-2 yellow)
    (rainbow-3 green)
    (rainbow-4 blue)
    (rainbow-5 cyan)
    (rainbow-6 magenta-warmer)
    (rainbow-7 green-warmer)
    (rainbow-8 blue-warmer)))

(defcustom modern-ayu-mirage-palette-overrides nil
  "Overrides for `modern-ayu-mirage-palette'."
  :group 'modern-ayu-mirage
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-ayu-mirage-palette
  (modus-themes-generate-palette
   modern-ayu-mirage-palette-partial
   nil
   nil
   (append modern-ayu-mirage-palette-mappings-partial
           modern-ayu-mirage-palette-common)))

(modus-themes-theme
 'modern-ayu-mirage
 'modern-ayu-mirage
 "Ayu Mirage theme port."
 'dark
 'modern-ayu-mirage-palette
 nil
 'modern-ayu-mirage-palette-overrides
 nil)

(provide 'modern-ayu-mirage-theme)
;;; modern-ayu-mirage-theme.el ends here
