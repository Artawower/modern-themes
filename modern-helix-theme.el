;;; modern-helix-theme.el --- Helix editor theme port -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software...

;;; Commentary:
;;
;; The `modern-helix' theme is a direct port of the Helix editor theme
;; to the `modus-themes' structure.

;;; Code:

;;; modern-helix-theme.el --- Helix editor theme port -*- lexical-binding:t -*-

(require 'modus-themes)

(defconst modern-helix-palette-partial
  '(
    
    (cursor "#6F44F0")
    (bg-main "#3B224C")
    (bg-dim  "#2f1b3d")
    (bg-alt  "#540099")
    (fg-main "#A4A0E8")
    (fg-dim  "#786fa5")
    (fg-alt  "#dbbfef")
    (bg-active   "#540099")
    (bg-inactive "#3B224C")
    (border      "#4c305f")

    
    (red           "#F5666D")
    (red-warmer    "#ff7a82")
    (red-cooler    "#db4e55")
    (red-faint     "#a43a40")

    (green         "#9ff28f")
    (green-warmer  "#b0ff9e")
    (green-cooler  "#7de07a")
    (green-faint   "#4e8a54")

    (yellow        "#E8DCA0")
    (yellow-warmer "#f6eab0")
    (yellow-cooler "#d4c890")
    (yellow-faint  "#9d9366")

    (blue          "#0084C8")
    (blue-warmer   "#0466aa")
    (blue-cooler   "#1c9df0")
    (blue-faint    "#0c4a7a")

    (magenta        "#dbbfef")
    (magenta-warmer "#e8d0ff")
    (magenta-cooler "#c9a2e7")
    (magenta-faint  "#a67cc5")

    (cyan         "#cccccc")
    (cyan-warmer  "#e0e0e0")
    (cyan-cooler  "#b8b8b8")
    (cyan-faint   "#9a9a9a")

    
    (bg-added         "#213a28")
    (bg-added-faint   "#1a2e20")
    (bg-added-refine  "#285033")
    (fg-added         "#9ff28f")

    (bg-changed        "#3d3421")
    (bg-changed-faint  "#2c2619")
    (bg-changed-refine "#504429")
    (fg-changed        "#E8DCA0")

    (bg-removed        "#40252b")
    (bg-removed-faint  "#2e1a1e")
    (bg-removed-refine "#532e35")
    (fg-removed        "#F5666D")

    
    (bg-red-intense     "#4e2a32")
    (bg-green-intense   "#2d3e2b")
    (bg-yellow-intense  "#3c3826")
    (bg-blue-intense    "#203045")
    (bg-magenta-intense "#3b2a4d")
    (bg-cyan-intense    "#293238")

    (bg-red-subtle     "#3a262c")
    (bg-green-subtle   "#263127")
    (bg-yellow-subtle  "#312c21")
    (bg-blue-subtle    "#1b2435")
    (bg-magenta-subtle "#2f223f")
    (bg-cyan-subtle    "#212c2f")))

(defconst modern-helix-palette-common
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

(defconst modern-helix-palette-mappings-partial
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

(defcustom modern-helix-palette-overrides nil
  "Overrides for `modern-helix-palette'."
  :group 'modern-helix
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-helix-palette
  (modus-themes-generate-palette
   modern-helix-palette-partial
   nil
   nil
   (append modern-helix-palette-mappings-partial
           modern-helix-palette-common)))

(modus-themes-theme
 'modern-helix
 'modern-helix
 "Helix default theme port."
 'dark
 'modern-helix-palette
 nil
 'modern-helix-palette-overrides
 nil)

(provide 'modern-helix-theme)
;;; modern-helix-theme.el ends here
