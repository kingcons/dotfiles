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

;; Who doesn't love Quicklisp?
(load (expand-file-name "/home/redline/quicklisp/slime-helper.el"))
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

;; Indent .asd files like they're lisp...cause they are.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
