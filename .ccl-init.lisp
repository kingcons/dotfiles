(require 'asdf)

;; set up the load path for ASDF-INSTALL and then load it
;(pushnew "ccl:tools;asdf-install;" asdf:*central-registry* :test #'string-equal)
;; Now make sure we can load these ASDF-INSTALLed programs.
;(pushnew "home:.asdf-install-dir;systems;" asdf:*central-registry* :test #'string-equal)
;; load ASDF-INSTALL
;(asdf:oos 'asdf:load-op 'asdf-install)

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

;(import 'asdf-install:install 'cl-user)
;(setq asdf-install:*verify-gpg-signatures* nil)

;; add CTRL-D to exit
(setq ccl:*quit-on-eof* t)
