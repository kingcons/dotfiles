;; Will's keys

;; (require 'keys)

;; (mapc (lambda (key) (global-unset-key (read-kbd-macro key)))
;;        `("C-x v"   ; vc - magit for life!
;;          "C-x C-d" ; list-directory - dired is better
;;          "C-x C-z" ; suspend-frame - what! leave emace!
;;   ))

;; (mapcar (lambda (el)
;;         (destructuring-bind (key command) el
;;           (let ((key (if (listp key)
;;                          (if (eq window-system 'x)
;;                              (first key)
;;                            (second key))
;;                        key)))
;;             (global-set-key (read-kbd-macro key) command))))
;;       `(
;;         ;; remove suspend-frame
;;         ("C-z" ,nil)

;;         ;; movement
;;         ("<home>" beginning-of-buffer)
;;         ("<end>" end-of-buffer)
;;         ("C-c C-o" beginning-of-buffer)
;;         ("C-c C-g" end-of-buffer)
;;         (("<C-left>"  "M-[ d") backward-word)
;;         (("<C-right>" "M-[ c") forward-word)
;;         (("<C-up>"    "M-[ A") backward-paragraph)
;;         (("<C-down>"  "M-[ B") forward-paragraph)
;;         ("C-c C-l" goto-line)
;;         ("C-c p" ,(lambda () (interactive) (scroll-up 10)))
;;         ("C-c n" ,(lambda () (interactive) (scroll-down 10)))
;;         ("C-x C-\\" 'goto-last-change)

;;         ;; grep
;;         ("C-c C-v" lisp-grep-next)
;;         ("C-c g" grep)

;;         ;; search
;;         ("C-s" isearch-forward-regexp)
;;         ("C-r" isearch-backward-regexp)

;;         ;; web
;;         ("C-c c" chrome-here)

;;         ;; magit
;;         ("C-c i" magit-status)

;;         ("M-/" hippie-expand)

;;         ;; bookmarks
;;         ("C-c 7" bm-toggle)
;;         ("C-c 8" bm-previous)
;;         ("C-c 9" bm-next)

;;         ;; entire buffer
;;         ("C-x C-v" revert-buffer)
;;         ("C-c 5" hide-old-text)
;;         ("C-c 6" show-old-text)

;;         ;; lisp
;;         ("C-c C-a" switch-to-repl)
;;         ("C-c a" switch-to-dribble-file)
;;         ("C-c m" slime-macroexpand-1-inplace-downcase)
;;         ("C-c f" lisp-grep)
;;         ("C-c C-f" lisp-find-file)
;;         ("C-c ," slime-selector)
;;         ("C-c C-q" slime-eval-print-last-expression)
;;         ("C-x C-a" copy-symbol)

;;         ("C-c k" comment-region)
;;         ("C-c K" uncomment-region)

;;         ("C-c D" dictionary-lookup-definition)

;;         ;; work stack
;;         ("C-c x" push-work-stack)
;;         ("C-c w" show-work-stack)

;;         ;; blog
;;         ("C-c b" find-file-blog)

;;         ;; paredit
;;         (("<M-left>" "ESC <left>") paredit-forward-barf-sexp)
;;         (("<M-right>" "ESC <right>") paredit-forward-slurp-sexp)
;;         ("C-c (" paredit-mode)

;;         ;; erc
;;         ("C-c {" erc-track-switch-buffer)

;;         ;; life
;;         ("C-c t" find-file-life)

;;         ;; speach
;;         ("C-c s w" festival-say-word)
;;         ("C-c s r" festival-say-region)

;;         ;; fonts
;;         ("C-c C-=" increase-font-size)
;;         ("C-c C--" decrease-font-size)
;;         ("C-c C-0" reset-font-size)

;;         ;; imenu
;;         ("C-c TAB" imenu) ;; really C-c C-i

;;         ;; whitespace
;;         ("M-SPC" fixup-whitespace)

;;         ))


;; (defun clear-keys-from-map (map keys)
;;   (dolist (key keys)
;;     (define-key map (read-kbd-macro key) nil)))

;; (clear-keys-from-map paredit-mode-map '("<C-left>" "<C-right>"))


;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cA" 'switch-to-open-agenda)
;; (define-key global-map "\C-cr" 'org-remember)

;(global-set-key "\C-cp" 'planner-create-task-from-buffer)
;(global-set-key "\C-cr" 'remember)

;; (global-set-key "\C-ca" 'agrep)

;; (global-set-key "\C-c\C-z." 'browse-url-at-point)
;; (global-set-key "\C-c\C-zb" 'browse-url-of-buffer)
;; (global-set-key "\C-c\C-zr" 'browse-url-of-region)
;; (global-set-key "\C-c\C-zu" 'browse-url)
;; (global-set-key "\C-c\C-zv" 'browse-url-of-file)

;; (global-set-key "\C-c=" 'hs-toggle-hiding)

;; (define-key w3m-mode-map "z" 'w3m-previous-buffer)
;; (define-key w3m-mode-map "x" 'w3m-next-buffer)

;; (define-key w3m-mode-map "\M-[a" 'scroll-down-one-line)
;; (define-key w3m-mode-map "\M-[b" 'scroll-up-one-line)

;; (define-key anything-map (kbd "M-O a") 'anything-previous-page)
;; (define-key anything-map (kbd "M-O b") 'anything-next-page)

;; (global-set-key "\C-ca" 'anything)

;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (local-set-key "\C-c\C-zf" 'browse-url-of-dired-file))))


