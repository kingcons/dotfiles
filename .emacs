; C-u M-x slime will prompt you for what lisp implementation to use.
(setq slime-lisp-implementations
  '((ccl  ("ccl64"))
    (ecl  ("ecl"))
    (sbcl ("sbcl"))
    (sbcl-git ("/home/redline/builds/clbuild-dev/clbuild" "lisp"))))
(setq slime-default-lisp 'sbcl-git)
(setq inferior-lisp-program 
      "/home/redline/builds/clbuild-dev/clbuild lisp")
(add-to-list 'load-path
	     "/home/redline/builds/clbuild-dev/source/slime")
(add-to-list 'load-path
	     "/home/redline/builds/clbuild-dev/source/slime/contrib")
(setq slime-backend "/home/redline/builds/clbuild-dev/.swank-loader.lisp")
(setq inhibit-splash-screen t)
(load "/home/redline/builds/clbuild-dev/source/slime/slime.el")
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
	       slime-mdot-fu
	       slime-package-fu
	       slime-references
	       slime-repl
;;	       slime-sbcl-exts)
	       slime-scratch
	       slime-tramp
	       slime-xref-browser))
(slime-fuzzy-init)
(slime-scratch-init)
(slime-references-init)
(slime-mdot-fu-init)
(slime-indentation-init)
(slime-fontifying-fu-init)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)
	    (setq slime-complete-symbol*-fancy t)))
(slime-require :swank-listener-hooks)

;; Indent .asd files like they're lisp...cause they are.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; I've got the HyperSpec locally, why aren't I using it?
(setq common-lisp-hyperspec-root "/home/redline/builds/HyperSpec/")

;; Stinking greatness...even my GUI doesn't have a GUI
(menu-bar-mode 0)
(when (eq window-system 'x)
  (tool-bar-mode 0)
  (scroll-bar-mode))

(load-file "/usr/lib/factor/misc/fuel/fu.el")
(custom-set-variables
 '(fuel-listener-factor-binary "/usr/bin/f-bin")
 '(fuel-listener-factor-image "/home/redline/.factor/factor.image")
 '(indent-tabs-mode nil))

(require 'color-theme)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'load-path "/home/redline/builds/magit")
(require 'magit)
(add-to-list 'load-path "/home/redline/builds/clojure-mode")
(require 'clojure-mode)
;(add-to-list 'load-path "/home/redline/builds/swank-clojure")
;(require 'swank-clojure-autoload)
