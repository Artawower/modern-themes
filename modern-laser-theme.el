;;; modern-laser-theme.el --- Laser theme port -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software...

;;; Commentary:
;;
;; The `modern-laser' theme is a port of the Laser color scheme
;; from iTerm2 to the `modus-themes' structure.

;;; Code:

;;; modern-laser-theme.el --- Laser theme port -*- lexical-binding:t -*-

(require 'modus-themes)

(defconst modern-laser-palette-partial
  '(
    
    (cursor "#00FF9C")
    (bg-main "#030D18")
    (bg-dim  "#0A141E")
    (bg-alt  "#111A24")
    (fg-main "#F106E3")
    (fg-dim  "#9ca0b0")
    (fg-alt  "#FF8FFD")
    (bg-active   "#1A2330")
    (bg-inactive "#030D18")
    (border      "#1F2A38")

    
    (red           "#FF8373")
    (red-warmer    "#FF9383")
    (red-cooler    "#FF7363")
    (red-faint     "#E67363")

    (green         "#B4FB72")
    (green-warmer  "#C4FB82")
    (green-cooler  "#A4EB62")
    (green-faint   "#94DB52")

    (yellow        "#09BD8F")
    (yellow-warmer "#19CD9F")
    (yellow-cooler "#09AD7F")
    (yellow-faint  "#099D6F")

    (blue          "#FE6D73")
    (blue-warmer   "#FE7D83")
    (blue-cooler   "#FE5D63")
    (blue-faint    "#EE4D53")

    (magenta        "#FF8FFD")
    (magenta-warmer "#FF9FFD")
    (magenta-cooler "#FF7FED")
    (magenta-faint  "#EF6FDD")

    (cyan         "#D1D1FF")
    (cyan-warmer  "#E1E1FF")
    (cyan-cooler  "#C1C1FF")
    (cyan-faint   "#B1B1FF")

    
    (bg-added         "#0A1A0A")
    (bg-added-faint   "#051505")
    (bg-added-refine  "#0F2A0F")
    (fg-added         "#B4FB72")

    (bg-changed        "#1A0A0A")
    (bg-changed-faint  "#150505")
    (bg-changed-refine "#2A0F0F")
    (fg-changed        "#FE6D73")

    (bg-removed        "#0A0A1A")
    (bg-removed-faint  "#050515")
    (bg-removed-refine "#0F0F2A")
    (fg-removed        "#FF8FFD")

    
    (bg-red-intense     "#2A0F0F")
    (bg-green-intense   "#0F2A0F")
    (bg-yellow-intense  "#0F2A1A")
    (bg-blue-intense    "#0F0F2A")
    (bg-magenta-intense "#2A0F2A")
    (bg-cyan-intense    "#1A1A2A")

    (bg-red-subtle     "#1A0A0A")
    (bg-green-subtle   "#0A1A0A")
    (bg-yellow-subtle  "#0A1A0F")
    (bg-blue-subtle    "#0A0A1A")
    (bg-magenta-subtle "#1A0A1A")
    (bg-cyan-subtle    "#0F0F1A")))

(defconst modern-laser-palette-common
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

(defconst modern-laser-palette-mappings-partial
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

(defcustom modern-laser-palette-overrides nil
  "Overrides for `modern-laser-palette'."
  :group 'modern-laser
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-laser-palette
  (modus-themes-generate-palette
   modern-laser-palette-partial
   nil
   nil
   (append modern-laser-palette-mappings-partial
           modern-laser-palette-common)))

(modus-themes-theme
 'modern-laser
 'modern-laser
 "Laser theme port."
 'dark
 'modern-laser-palette
 nil
 'modern-laser-palette-overrides
 nil)

(provide 'modern-laser-theme)
;;; modern-laser-theme.el ends here
