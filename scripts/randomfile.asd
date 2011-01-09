(defsystem :randomfile
  :name "Randomfile"
  :description "A command line utility for performing actions on random files."
  :author "Brit Butler <redline6561@gmail.com>"
  :version "0.0.2"
  :license "BSD"
  :depends-on (:cl-fad :external-program)
  :serial t
  :components ((:file "randomfile")))
