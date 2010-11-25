(setq-default indent-tabs-mode nil)

(add-hook 'write-file-hooks 'delete-trailing-whitespace)

(setq whitespace-style '(tabs trailing))

(add-hook 'lisp-mode-hook 'whitespace-mode)
(add-hook 'clojure-mode-hook 'whitespace-mode)
