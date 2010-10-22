(push "/home/redline/projects/clockwork/" asdf:*central-registry*)

(require 'clockwork)

(require 'swank)
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
