(set-default 'auto-mode-alit
             (append '(("\\.org$" . org-mode)
                       ("\\.asd$" . lisp-mode)
                       ("\\.clj$" . clojure-mode)))
             auto-mode-alist)
