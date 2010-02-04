;; C-u M-x slime will prompt you for what lisp implementation to use.
(setq slime-lisp-implementations
  '((ccl  ("ccl64"))
    (ecl  ("ecl"))
    (sbcl ("sbcl"))))
(setq slime-default-lisp 'sbcl)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/contrib/")
(require 'slime)
(slime-setup '(slime-asdf
	       slime-repl
               slime-fancy
	       slime-fontifying-fu
	       slime-indentation
	       slime-c-p-c
	       slime-editing-commands
	       slime-scratch
	       slime-mdot-fu
	       slime-package-fu
	       slime-references))
;;	       slime-sbcl-exts))
(slime-fuzzy-init)
(slime-scratch-init)
(slime-references-init)
(slime-mdot-fu-init)
(slime-indentation-init)
(slime-fontifying-fu-init)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)))

(require 'color-theme)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)