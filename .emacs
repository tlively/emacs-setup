(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set C style to Kernighan and Ritchie to make everything better
(setq c-default-style "k&r"
      c-basic-offset 4)

;; remove menu bar
(menu-bar-mode -1)

;; enable spell checking
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; enable column number mode by default
(setq column-number-mode t)

;; highlight code that extends past 80 columns when editing code
(require 'whitespace)
(setq whitespace-line-column 81)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(add-hook 'prog-mode-hook (lambda () (whitespace-mode 1)))

;; turn on fancy c mode features
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-toggle-electric-state 1)
	    (c-toggle-auto-newline 1)
	    (c-toggle-hungry-state 1)
	    (c-toggle-syntactic-indentation 1)
	    (subword-mode)
	    (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
	    (setq c-hanging-braces-alist (cons '(defun-open . (after))
					       c-hanging-braces-alist))
	    (setq c-hanging-braces-alist (cons '(class-open . (after))
					       c-hanging-braces-alist))
	    (hs-minor-mode)))

;; -- Tuareg mode -----------------------------------------
;; Add Tuareg to your search path
(add-to-list
'load-path
 ;; Change the path below to be wherever you've put your tuareg installation.
  (expand-file-name "~/.elisp/tuareg-mode"))
(require 'tuareg)
(require 'cl)
(setq auto-mode-alist
     (append '(("\.ml[ily]?$" . tuareg-mode))
     auto-mode-alist))

;; -- Tweaks for OS X -------------------------------------
;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; init scripts when invoking a sub-shell
(cond
((eq window-system 'ns) ; macosx
  ;; Invoke login shells, so that .profile or .bash_profile is read
    (setq shell-command-switch "-lc")))

;; -- opam and utop setup --------------------------------
;; Setup environment variables using opam
(defun opam-vars ()
 (let* ((x (shell-command-to-string "opam config env"))
    (x (split-string x "\n"))
(x (remove-if (lambda (x) (equal x "")) x))
    (x (mapcar (lambda (x) (split-string x ";")) x))
(x (mapcar (lambda (x) (car x)) x))
    (x (mapcar (lambda (x) (split-string x "=")) x))
)
     x))
(dolist (var (opam-vars))
 (setenv (car var) (substring (cadr var) 1 -1)))
;; The following simpler alternative works as of opam 1.1
;; (dolist
;;    (var (car (read-from-string
;;       (shell-command-to-string "opam config env --sexp"))))
;;  (setenv (car var) (cadr var)))
;; Update the emacs path
(setq exec-path (split-string (getenv "PATH") path-separator))
;; Update the emacs load path
(push (concat (getenv "OCAML_TOPLEVEL_PATH")
         "/../../share/emacs/site-lisp") load-path)
;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
