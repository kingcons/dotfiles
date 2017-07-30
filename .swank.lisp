#+sbcl
(push (lambda (&rest args)
        (apply #'swank:ed-in-emacs args)
        t)
      sb-ext:*ed-functions*)

#+ccl
(setq ccl:*resident-editor-hook* #'swank:ed-in-emacs)
