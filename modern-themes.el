;;; modern-themes.el --- Colorful and legible themes -*- lexical-binding:t -*-

;; Copyright (C) 2025  Free Software Foundation, Inc.

;; Author: artawower33@gmail.com
;; Maintainer: artawower
;; URL: https://github.com/artawower/modern-themes
;; Version: 1.0.0
;; Package-Requires: ((emacs "28.1") (modus-themes "5.0.0"))
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
;; The `modern-themes' are a collection of light and dark themes for GNU
;; Emacs.  They are built on top of the `modus-themes' structure,
;; providing colorful and legible options.
;;
;; Available themes:
;; - `modern-deep-atom' (dark): Deep Atom theme port
;; - `modern-pinkywinky` (light): Legible light theme inspired by Pinky Winky
;; - `modern-pinkywinky-dark' (dark): Legible dark theme inspired by Pinky Winky
;; - `modern-zaiste` (light): Modern Zaiste theme port
;; - `modern-nano-light` (light): Modern Nano Light theme port
;; - `modern-nano-dark` (dark): Modern Nano Dark theme port
;; - `modern-tokyo` (dark): Modern Tokyo theme port
;; - `modern-catppuccin-latte` (light): Catppuccin Latte theme port
;; - `modern-catppuccin-frappe` (dark): Catppuccin Frappe theme port
;; - `modern-catppuccin-macchiato` (dark): Catppuccin Macchiato theme port
;; - `modern-catppuccin-mocha` (dark): Catppuccin Mocha theme port
;;
;; Usage:
;;   (require 'modern-themes)
;;   (load-theme 'modern-deep-atom t)

;;; Code:

(require 'modus-themes)

;;;; Customization group

(defgroup modern-themes ()
  "Colorful and legible themes.
The `modern-themes' are built on top of the `modus-themes'."
  :group 'faces
  :group 'modus-themes
  :link '(url-link :tag "Homepage" "https://github.com/artawower/modern-themes")
  :prefix "modern-themes-"
  :tag "Modern Themes")

;;;; Theme lists

(defconst modern-themes-light-themes
  '(modern-pinkywinky
    modern-zaiste
    modern-nano-light
    modern-catppuccin-latte)
  "List of symbols with the light Modern themes.")

(defconst modern-themes-dark-themes
  '(modern-deep-atom
    modern-nano-dark
    modern-pinkywinky-dark
    modern-tokyo
    modern-catppuccin-frappe
    modern-catppuccin-macchiato
    modern-catppuccin-mocha)
  "List of symbols with the dark Modern themes.")

(defconst modern-themes-items
  (append modern-themes-light-themes modern-themes-dark-themes)
  "Symbols of all the Modern themes.")

;;;; Add themes from package to path

;;;###autoload
(when load-file-name
  (let ((dir (file-name-directory load-file-name)))
    (unless (file-equal-p dir (expand-file-name "themes/" data-directory))
      (add-to-list 'custom-theme-load-path dir))))

(provide 'modern-themes)
;;; modern-themes.el ends here
