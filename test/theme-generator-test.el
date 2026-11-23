;;; theme-generator-test.el --- Tests for theme-generator -*- lexical-binding:t -*-

;;; Code:

(require 'ert)

(add-to-list 'load-path
             (file-name-directory
              (directory-file-name
               (file-name-directory (or load-file-name buffer-file-name)))))
(require 'theme-generator)

(defconst mtg-test--dark-palette
  '(bg-main "#292828"
    fg-main "#D4BE98"
    fg-dim "#7C6F64"
    fg-alt "#CCB692"
    red "#EA6962"
    green "#A8B665"
    yellow "#D8A658"
    blue "#7DAEA3"
    magenta "#D3859B"
    cyan "#89B482"))

(ert-deftest mtg-contrast-ratio-uses-wcag-luminance ()
  (should (< (abs (- (mtg--contrast-ratio "#000000" "#ffffff") 21.0))
             0.001))
  (should (= (mtg--contrast-ratio "#292828" "#292828") 1.0)))

(ert-deftest mtg-ensure-contrast-preserves-readable-colors ()
  (should (equal (mtg--ensure-contrast "#D4BE98" "#292828" 4.5)
                 "#D4BE98")))

(ert-deftest mtg-ensure-contrast-rejects-impossible-ratios ()
  (should-error (mtg--ensure-contrast "#777777" "#292828" 21.0)
                :type 'error))

(ert-deftest mtg-ensure-contrast-corrects-dark-and-light-palettes ()
  (dolist (pair '(("#7C6F64" . "#292828")
                  ("#D7AF5F" . "#F2F2F2")))
    (let ((corrected (mtg--ensure-contrast (car pair) (cdr pair) 4.5)))
      (should (>= (mtg--contrast-ratio corrected (cdr pair)) 4.5))
      (should-not (equal corrected (car pair))))))

(ert-deftest mtg-generated-foregrounds-meet-minimum-contrast ()
  (let* ((palette (mtg--normalize-foreground-palette
                   mtg-test--dark-palette 4.5))
         (background (plist-get palette 'bg-main))
         (colors (mtg--generate-fg-colors palette 4.5)))
    (dolist (entry colors)
      (should (>= (mtg--contrast-ratio (cdr entry) background) 4.5)))))

(ert-deftest mtg-terminal-neutral-mappings-follow-theme-variant ()
  (let ((dark (mtg--render-mappings-partial "test" nil 'dark))
        (light (mtg--render-mappings-partial "test" nil 'light)))
    (should (string-match-p "(fg-term-black fg-dim)" dark))
    (should (string-match-p "(fg-term-black-bright fg-dim)" dark))
    (should (string-match-p "(fg-term-black fg-main)" light))
    (should (string-match-p "(fg-term-black-bright fg-dim)" light))
    (dolist (output (list dark light))
      (should (string-match-p "(fg-term-white fg-dim)" output))
      (should (string-match-p "(fg-term-white-bright fg-main)" output)))))

(ert-deftest mtg-diff-colors-preserve-syntax-foregrounds ()
  (let ((colors (mtg--generate-diff-colors mtg-test--dark-palette 'dark)))
    (dolist (key '(fg-added fg-changed fg-removed))
      (should-not (assq key colors))
      (should (eq (cadr (assq key mtg--palette-common)) 'unspecified)))
    (dolist (key '(bg-added bg-changed bg-removed
                   bg-added-refine bg-changed-refine bg-removed-refine))
      (should (mtg--hex-p (alist-get key colors))))))

(ert-deftest mtg-diff-colors-follow-theme-accents ()
  (let* ((palette mtg-test--dark-palette)
         (colors (mtg--generate-diff-colors palette 'dark))
         (bg-main (plist-get palette 'bg-main)))
    (should (equal (alist-get 'bg-added colors)
                   (mtg--blend bg-main (plist-get palette 'green) 0.15)))
    (should (equal (alist-get 'bg-removed colors)
                   (mtg--blend bg-main (plist-get palette 'red) 0.15)))
    (should-not (equal (alist-get 'bg-added colors)
                       (alist-get 'bg-removed colors)))
    (should (eq (cadr (assq 'bg-diff-context mtg--palette-common))
                'bg-main))))

(provide 'theme-generator-test)
;;; theme-generator-test.el ends here
