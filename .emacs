;; Htmlize, just because it's handy
(load "/home/redline/builds/emacs-bits/htmlize.el")

;; Magit
(add-to-list 'load-path "/home/redline/builds/emacs-bits/magit")
(require 'magit)

;; Stinking greatness...even my GUI doesn't have a GUI
(menu-bar-mode 0)
(when (eq window-system 'x)
  (tool-bar-mode 0)
  (scroll-bar-mode))

;; Color Theme. Colors matter...
(require 'color-theme)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun color-theme-dark-bliss ()
  (interactive)
  (color-theme-install
   '(color-theme-dark-bliss
     ((foreground-color . "#eeeeee")
      (background-color . "#001122")
      (background-mode . dark)
      (cursor-color . "#ccffcc"))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))

     (font-lock-builtin-face ((t (:foreground "#f0f0aa"))))
     (font-lock-comment-face ((t (:italic t :foreground "#aaccaa"))))
     (font-lock-delimiter-face ((t (:foreground "#aaccaa"))))
     (font-lock-constant-face ((t (:bold t :foreground "#ffaa88"))))
     (font-lock-doc-string-face ((t (:foreground "#eeccaa"))))
     (font-lock-doc-face ((t (:foreground "#eeccaa"))))
     (font-lock-reference-face ((t (:foreground "#aa99cc"))))
     (font-lock-function-name-face ((t (:foreground "#ffbb66"))))
     (font-lock-keyword-face ((t (:foreground "#ccffaa"))))
     (font-lock-preprocessor-face ((t (:foreground "#aaffee"))))
     (font-lock-string-face ((t (:foreground "#bbbbff")))))))
(color-theme-dark-bliss)

;; Ocaml stuff
;; (setq auto-mode-alist (cons '("\\.ml[iylp]?\\'" . tuareg-mode) auto-mode-alist))
;; (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
;; (autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;; Factor stuff
(load-file "/usr/lib/factor/misc/fuel/fu.el")
(custom-set-variables
 '(fuel-listener-factor-binary "/usr/bin/f-bin")
 '(fuel-listener-factor-image "/home/redline/.factor/factor.image")
 '(indent-tabs-mode nil))

;;; Common Lisp Stuff
;; Who doesn't love Quicklisp?
(load (expand-file-name "/media/redlinux/home/redline/Desktop/quicklisp/slime-helper.el"))
; C-u M-x slime will prompt you for what lisp implementation to use.
(setq slime-lisp-implementations
  '((ccl  ("ccl64"))
    (ecl  ("ecl"))
    (sbcl ("sbcl"))
    (sbcl-git ("/home/redline/builds/clbuild-dev/clbuild" "lisp"))))
(setq slime-default-lisp 'sbcl)
(setq inhibit-splash-screen t)
(require 'slime)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(setq slime-use-autodoc-mode t)
(slime-setup '(slime-asdf
	       slime-autodoc
	       slime-c-p-c
	       slime-editing-commands
               slime-fancy
	       slime-fancy-inspector
	       slime-fontifying-fu
	       slime-fuzzy
	       slime-indentation
	       ;slime-mdot-fu ;;warning - this junk is deprecated! are any of the others?
	       slime-package-fu
	       slime-references
	       slime-repl
	       slime-sbcl-exts
	       slime-scratch
	       slime-tramp
	       slime-xref-browser))
(slime-fuzzy-init)
(slime-scratch-init)
(slime-references-init)
; (slime-mdot-fu-init) ;;warning - this junk is deprecated!
(slime-indentation-init)
(slime-fontifying-fu-init)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)
            (setq slime-complete-symbol*-fancy t)))
(slime-require :swank-listener-hooks)

;; Clojure stuff
(add-to-list 'load-path "/usr/share/emacs/site-lisp/clojure-mode")
(require 'clojure-mode)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/swank-clojure")
(require 'swank-clojure)
(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map "\C-c\C-e" 'lisp-eval-last-sexp)
             (define-key clojure-mode-map "\C-x\C-e" 'lisp-eval-last-sexp)))
(eval-after-load "slime"
  `(progn
     (require 'assoc)
     (setq swank-clojure-classpath
           (list "/usr/share/clojure/clojure.jar"
                 "/usr/share/clojure/clojure-contrib.jar"
                 "/usr/share/emacs/site-lisp/swank-clojure/src"))
     (aput 'slime-lisp-implementations 'clojure
           (list (swank-clojure-cmd) :init 'swank-clojure-init))))

;; I've got the HyperSpec locally, why aren't I using it?
(setq common-lisp-hyperspec-root "/home/redline/builds/HyperSpec/")

;; Indent .asd files like they're lisp...cause they are.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; Paredit
(load "/home/redline/builds/emacs-bits/paredit.el")
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook
;;           (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook
;;           (lambda () (paredit-mode +1)))
;; (add-hook 'slime-repl-mode-hook
;;           (lambda () (paredit-mode +1)))

          ;; Stop SLIME's REPL from grabbing DEL,
          ;; which is annoying when backspacing over a '('
;          (defun override-slime-repl-bindings-with-paredit ()
;            (define-key slime-repl-mode-map
;                (read-kbd-macro paredit-backward-delete-key) nil))
;                (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
