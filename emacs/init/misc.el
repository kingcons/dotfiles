;; Htmlize, just because it's handy
(load "htmlize.el")

;; Indent .asd files like they're lisp...cause they are.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

