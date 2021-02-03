;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" default)))
 '(display-time-mode t)
 '(doc-view-continuous t)
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (clang-format csv-mode pdf-tools org-bullets auctex company org yasnippet monokai-theme markdown-mode company-auctex)))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;
;; PACKAGES ;;
;;;;;;;;;;;;;;

(add-to-list 'package-archives ;; stable versions
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
 	     '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives 
;;              '("org" . "https://orgmode.org/elpa/") t)

;;;;;;;;;;;;;;;
;; PDF-TOOLS ;;
;;;;;;;;;;;;;;;

(pdf-tools-install)

;;;;;;;;;
;; IDK ;;
;;;;;;;;;

(server-start)

;;;;;;;;;;;;;
;; COMPANY ;;
;;;;;;;;;;;;;

(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;
;; ORG-MODE ;;
;;;;;;;;;;;;;;

(require 'org-bullets)
(setq org-bullets-bullet-list '("◉" "◎" "⚫" "○" "►" "◇"))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-hide-leading-stars t)
(setq org-ellipsis "⤵")
(setq org-src-fontify-natively t)
(setq org-src-window-setup 'current-window)
(org-babel-do-load-languages 'org-babel-load-languages 
			     '((C . t)
			       (emacs-lisp . t) 
			       (latex . t)
			       (org . t)
			       (python . t)
			       (shell . t)
			       ))

;;;;;;;;;;;;;;;
;; YASNIPPET ;;
;;;;;;;;;;;;;;;

(require 'yasnippet)
(yas-global-mode 1)

;;;;;;;;;;;;
;; AUCTEX ;;
;;;;;;;;;;;;

(require 'company-auctex)

;; These are the hooks I want to enable during LaTeX-mode
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (company-auctex-init) ;; init company-auctex
	    (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
		  TeX-source-correlate-mode t)
	    (global-set-key (kbd "C-c C-g") 'pdf-sync-forward-search) ;; sync from text to pdf
	    (add-hook 'TeX-after-compilation-finished-functions
		      #'TeX-revert-document-buffer) ;; reload pdf after compilation
	    )
	  )

;;;;;;;;;;;;;;
;; CSV-MODE ;;
;;;;;;;;;;;;;;

(setq csv-separators '("," ":"))

;;;;;;;;;;;;;;;;;;
;; CLANG-FORMAT ;;
;;;;;;;;;;;;;;;;;;

(global-set-key [C-M-tab] 'clang-format-region)
