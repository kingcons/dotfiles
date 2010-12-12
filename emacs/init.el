(add-to-list 'load-path "~/emacs/site-lisp")

(mapcar (lambda (name)
          (load-file (expand-file-name
                      (format "%s/%s.el" "~/emacs/init" name))))
        '("automode"
          "clojure"
          "color-theme"
          "display"
          "elisp"
          "factor"
          "haskell"
          "keybindings"
          "magit"
          "misc"
          "modeline"
          "ocaml"
          "paredit"
          "scheme"
          "slime"
          "w3m"
          "whitespace"))
