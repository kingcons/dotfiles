(add-to-list 'load-path "~/emacs/site-lisp")

(mapcar (lambda (name)
          (load-file (expand-file-name (format "%s/%s.el" "~/emacs/init" name))))
        '("clojure"
          "color-theme"
          "display"
          "elisp"
          "factor"
          ;"keybindings"
          ;"magit"
          "misc"
          "modeline"
          ;"ocaml"
          "paredit"
          "slime"
          "w3m"
          "whitespace"))
