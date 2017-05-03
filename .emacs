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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages (quote (default-text-scale rust-mode rustfmt))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; flag for CS161-specific features
(setq cs-161 nil)

(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

;; let GUI emacs find aspell
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; set up bash_profile for emacs shell
(setq explicit-bash-args
      '("--login" "--init-file" "~/.bash_profile" "-i"))

;; remove menu bar
(menu-bar-mode -1)

;; remove tool bar
(tool-bar-mode -1)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000) ;; don't jump when scrolling

;; match comment and code length
(set-fill-column 80)

;; automatically reload changed files
(global-auto-revert-mode t)

;; use spaces, not tabs
(setq-default indent-tabs-mode nil)

;; enable spell checking
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; enable column number mode by default
(setq column-number-mode t)

;; enable matching paren highlighting by default
(setq show-paren-delay 0)
(show-paren-mode 1)

;; highlight code that extends past 80 columns when editing code
(require 'whitespace)
(setq whitespace-line-column 80)
;;(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty tabs lines-tail))
(add-hook 'prog-mode-hook (lambda () (whitespace-mode 1)))

;; remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; turn on syntactic echoing for debugging
(setq c-echo-syntactic-information-p t)

;; move backup files to another location
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; turn on fancy C mode features
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-default-style (if cs-161 "linux" "k&r")
                  c-basic-offset (if cs-161 8 4))
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
                     (inline-close after)
                     (arglist-cont-nonempty)))
            (setq c-cleanup-list
                  '(empty-defun-braces
                    defun-close-semi
                    list-close-comma
                    scope-operator))
            (hs-minor-mode)))

;; switch styles for C++
(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-default-style "stroustrup")))
(put 'upcase-region 'disabled nil)

;; add word wrapping for latex mode
(add-hook 'latex-mode-hook
          (lambda()
            (set-fill-column 80)
            (turn-on-auto-fill)))

;; make C-x work as expected in term mode
(add-hook 'term-mode-hook
          '(lambda ()
             (term-set-escape-char ?\C-x)))

;; make switching between term modes painless
(require 'term)
(defun term-toggle-mode ()
  "Toggles term between line mode and char mode"
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))
(define-key term-mode-map (kbd "C-j") 'term-toggle-mode)
(define-key term-raw-map (kbd "C-j") 'term-toggle-mode)

;; make rust mode work
(setq rust-format-on-save 't)
(setq rust-rustfmt-bin "/Users/Thomas/.cargo/bin/rustfmt")

;; tuareg mode (OCaml)
(load "/Users/thomas/.opam/system/share/emacs/site-lisp/tuareg-site-file")
(setq tuareg-match-patterns-aligned t)

;; Open .v files with Proof General's Coq mode
(load "~/.emacs.d/lisp/PG/generic/proof-site")
