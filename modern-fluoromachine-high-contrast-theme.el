;;; modern-fluoromachine-high-contrast-theme.el --- Fluoromachine High-Contrast port -*- lexical-binding:t -*-

;; Copyright (C) 2025

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;;; Commentary:
;;
;; The `modern-fluoromachine-high-contrast' theme is a high-contrast neon
;; variant inspired by Fluoromachine.nvim, ported to the `modus-themes' structure.

;;; Code:

(require 'modus-themes)

(defconst modern-fluoromachine-high-contrast-palette-partial
  '((cursor "#f8f8f2")
    (bg-main "#000000")
    (bg-dim  "#0a0a0f")
    (bg-alt  "#11111a")
    (fg-main "#f8f8f2")
    (fg-dim  "#8a8a9a")
    (fg-alt  "#bfbfd5")
    (bg-active "#1a1a22")
    (bg-inactive "#000000")
    (border "#222233")

    (red           "#ff2a6d")
    (red-warmer    "#ff4b84")
    (red-cooler    "#e02060")
    (red-faint     "#b83963")

    (green         "#00ffa6")
    (green-warmer  "#3dffb9")
    (green-cooler  "#00d78c")
    (green-faint   "#3aa680")

    (yellow        "#faff00")
    (yellow-warmer "#ffea3d")
    (yellow-cooler "#d4d400")
    (yellow-faint  "#9d9d39")

    (blue          "#1a9bff")
    (blue-warmer   "#4bb4ff")
    (blue-cooler   "#0f7ad6")
    (blue-faint    "#2d5fa1")

    (magenta       "#d900ff")
    (magenta-warmer "#ea4dff")
    (magenta-cooler "#b200d6")
    (magenta-faint  "#9a38b1")

    (cyan         "#00eaff")
    (cyan-warmer  "#3df2ff")
    (cyan-cooler  "#00c2d7")
    (cyan-faint   "#2d9aa6")

    (bg-red-intense "#240010")
    (bg-green-intense "#001809")
    (bg-yellow-intense "#1a1a00")
    (bg-blue-intense "#001426")
    (bg-magenta-intense "#1a0024")
    (bg-cyan-intense "#001a1a")

    (bg-red-subtle "#320018")
    (bg-green-subtle "#002411")
    (bg-yellow-subtle "#262600")
    (bg-blue-subtle "#001f33")
    (bg-magenta-subtle "#260033")
    (bg-cyan-subtle "#00262e")

    (bg-added         "#002411")
    (bg-added-faint   "#001809")
    (bg-added-refine  "#005f3c")
    (fg-added         "#00ffa6")

    (bg-changed        "#262600")
    (bg-changed-faint  "#1a1a00")
    (bg-changed-refine "#9d9d39")
    (fg-changed        "#faff00")

    (bg-removed        "#320018")
    (bg-removed-faint  "#240010")
    (bg-removed-refine "#b83963")
    (fg-removed        "#ff2a6d")

    (bg-mode-line-active-col "#0a0a0f")
    (bg-hover-col "#11111a")
    (bg-hover-secondary-col "#0a0a0f")
    (bg-paren-match-col "#222233")))

(defconst modern-fluoromachine-high-contrast-palette-common
  '((fringe unspecified)
    (fg-region unspecified)
    (bg-diff-context bg-dim)
    (bg-tab-bar bg-alt)
    (bg-tab-current bg-main)
    (bg-tab-other bg-dim)))

(defconst modern-fluoromachine-high-contrast-palette-mappings-partial
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

    (fg-link cyan)
    (fg-link-visited blue-cooler)

    (builtin magenta)
    (comment fg-dim)
    (constant cyan)
    (fnname magenta)
    (keyword red)
    (preprocessor red)
    (docstring fg-dim)
    (string green)
    (type magenta)
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

(defcustom modern-fluoromachine-high-contrast-palette-overrides nil
  "Overrides for `modern-fluoromachine-high-contrast-palette'."
  :group 'modern-fluoromachine-high-contrast
  :type '(repeat (list symbol (choice symbol string))))

(defconst modern-fluoromachine-high-contrast-palette
  (modus-themes-generate-palette
   modern-fluoromachine-high-contrast-palette-partial
   nil
   nil
   (append modern-fluoromachine-high-contrast-palette-mappings-partial
           modern-fluoromachine-high-contrast-palette-common)))

(modus-themes-theme
 'modern-fluoromachine-high-contrast
 'modern-fluoromachine-high-contrast
 "Fluoromachine High-Contrast theme port."
 'dark
 'modern-fluoromachine-high-contrast-palette
 nil
 'modern-fluoromachine-high-contrast-palette-overrides)

(provide 'modern-fluoromachine-high-contrast-theme)

;;; modern-fluoromachine-high-contrast-theme.el ends here
