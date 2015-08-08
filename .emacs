(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; remove menu bar
(menu-bar-mode -1)

;; use spaces, not tabs
(setq-default indent-tabs-mode nil)

;; enable spell checking
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; enable column number mode by default
(setq column-number-mode t)

;; highlight code that extends past 80 columns when editing code
(require 'whitespace)
(setq whitespace-line-column 81)
;;(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty tabs lines-tail))
(add-hook 'prog-mode-hook (lambda () (whitespace-mode 1)))

;; turn on fancy C mode features
(add-hook 'c-mode-common-hook
	  (lambda ()
            (setq c-default-style "k&r"
		  c-basic-offset 4)
	    (c-toggle-electric-state 1)
	    (c-toggle-auto-newline 1)
	    (c-toggle-hungry-state 1)
	    (c-toggle-syntactic-indentation 1)
	    (subword-mode)
	    (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
            (setq c-hanging-braces-alist
                  '((brace-list-open)
                     (brace-entry-open)
                     (statement-cont)
                     (substatement-open after)
                     (block-close . c-snug-do-while)
                     (extern-lang-open after)
                     (namespace-open after)
                     (module-open after)
                     (composition-open after)
                     (inexpr-class-open after)
                     (inexpr-class-close before)
                     (defun-open after)
                     (class-open after)
                     (class-close)
                     (inline-open after)
                     (inline-close after)))
            (setq c-cleanup-list
                  '(empty-defun-braces
                    defun-close-semi
                    list-close-comma
                    scope-operator
                    one-liner-defun))
	    (hs-minor-mode)))

;; switch styles for C++
(add-hook 'c++-mode-hook
	  (lambda ()
	    (setq c-default-style "stroustrup")))
(put 'upcase-region 'disabled nil)
