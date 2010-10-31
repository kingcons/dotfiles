;; We have to manually symlink our personal and bleeding-edge stuff this way...
;; but that's better for now than clbuild in addition to quicklisp or pushing
;; a ton of paths onto the central registry.
(push "/home/redline/projects/systems/" asdf:*central-registry*)

;; This is fragile and unfortunate and will need to change.
;; Right now it makes my life easier because it was trying to load, I think, clojure-swank
;; from /usr/share/emacs/site-lisp as installed from AUR and failing pretty hard.
(push "/home/redline/quicklisp/dists/quicklisp/software/slime-20101006-cvs/" asdf:*central-registry*)

(ql:quickload '(weblocks swank))
;; This will be able to disappear when form-widget leaves contrib.
(load "/home/redline/projects/weblocks-dev/contrib/lpolzer/form-widget.lisp")

(setf swank-loader::*contribs* '(swank-c-p-c swank-arglists
				 swank-fuzzy swank-fancy-inspector
				 swank-package-fu))
(swank-loader::loadup)
(swank:create-server :dont-close t
		     :port 4010
		     :coding-system "utf-8-unix")

(ql:quickload '(clockwork))

(in-package :clockwork)
(start-clockwork :port 4242)
