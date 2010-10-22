(require 'asdf)

;; Make it so we can load via ASDF just by using REQUIRE (I'm lazy)
;; mostly stolen from http://www.mail-archive.com/cmucl-help-bounce@cons.org/msg02514.html
(defun module-provide-asdf (name)
  (let* ((name (string-downcase name))
     (system (asdf:find-system name nil)))
    (when system
      (asdf:oos 'asdf:load-op name)
      t)))

(setf asdf:*central-registry* '("/home/redline/builds/clbuild-dev/systems/" *default-pathname-defaults*))

;; hook it in
(pushnew 'module-provide-asdf *module-provider-functions*)

;; add CTRL-D to exit
(setq ccl:*quit-on-eof* t)

;;; The following lines added by ql:add-to-init-file:
#-quicklisp
(let ((quicklisp-init #p"/media/redlinux/home/redline/Desktop/quicklisp/setup.lisp"))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
