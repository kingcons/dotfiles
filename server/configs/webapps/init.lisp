(push "/home/redline/projects/clockwork/" asdf:*central-registry*)
(push "/home/redline/projects/weblocks-dev/" asdf:*central-registry*)

;; This is fragile and unfortunate and will need to change.
;; Right now it makes my life easier because it was trying to load, I think, clojure-swank
;; from /usr/share/emacs/site-lisp as installed from AUR and failing pretty hard.
(push "/home/redline/quicklisp/dists/quicklisp/software/slime-20101006-cvs/" asdf:*central-registry*)

(ql:quickload '(clockwork swank))

(setf swank-loader::*contribs* '(swank-c-p-c swank-arglists
				 swank-fuzzy swank-fancy-inspector
				 swank-package-fu))
(swank-loader::loadup)
(swank:create-server :dont-close t
		     :port 4010
		     :coding-system "utf-8-unix")

(in-package :clockwork)
(start-clockwork :port 4242)

;; probably should be split into init.lisp or main.lisp in mtg/src/...
;(in-package :mtg)
;(load-data)
