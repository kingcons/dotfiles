#!/usr/bin/sbcl --script
(declaim (sb-ext:muffle-conditions style-warning))

;; The world's greatest worst lisp backup script.
;; And yes, just using a shell script would probably make way more sense.

;; Backup space breakdown:
;; ~/docs is ~8GB. ~4GB without "sources".
;; /media/redlinux/~/images is ~1G.
;; ~/projects is ~500mb.
;; ~5-6 gigs total.
;; Thank God for rsync, http://cs.anu.edu.au/techreports/1996/TR-CS-96-05.pdf

;; NOTES and TODO:
;; Do mozilla's $hash.default/ directories change on upgrade?

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((*standard-output* (make-broadcast-stream))
        (*error-output* (make-broadcast-stream)))
    (load "/home/redline/.sbclrc")
    (require 'external-program)
    (require 'split-sequence)
    (require 'zs3)))

(defpackage :backup
  (:use :cl)
  (:import-from :external-program #:run)
  (:import-from :sb-ext #:run-program)
  (:import-from :split-sequence #:split-sequence))

(in-package :backup)

(defvar *home* (sb-posix:getenv "HOME"))
(defvar *log* "docs/logs/backups")

(defvar *sessions*
  '(".mozilla/firefox/7nnhqw2r.default/sessionstore.js"
    ".config/chromium/Default/Current Session"
    ".config/chromium/Default/Current Tabs"
    ".conkeror.mozdev.org/conkeror/sk3mzb89.default/sessions/auto-save"))

(defvar *secrets*
  '(".ssh/"
    ".gnupg/"))

(defvar *separate-dirs*
  ;; My ~/{docs,images,projects} are symlinks to an old partition.
  '("/media/redlinux/home/redline/docs"
    "/media/redlinux/home/redline/images"
    "/media/redlinux/home/redline/projects"))

(defvar *servers*
  '("redlinernotes.com"
    "clockwork-webdev.com"))

(defun tar-create (tar paths)
  (run "tar" `("-cvf" ,tar ,@paths))
  tar)

(defun bzip-it (path)
  (run "bzip2" (list path))
  (format nil "~a.bz2" path))

(defun sync (path files logfile server)
  (format t "Syncing ~a to ~a...~%" path server)
  (upload (bzip-it (tar-create (format nil "~a/~a.tar" *home* path)
                               (loop for path in files collecting
                                    (format nil "~a/~a" *home* path))))
          (format nil "~a/~a" logfile path) server)
  (delete-file (format nil "~a/~a.tar.bz2" *home* path))
  (format t "Transfer complete. ~a:~a is backed up.~%" path server))

(defun upload (path logfile server)
  (let ((env-vars (with-open-file (in (format nil "~a/.ssh/agent.env" *home*))
                    (list (read-line in) (read-line in)))))
    (format t "Starting rsync for ~A~%" path)
    (run-program "rsync" (list "-avz" "--delete" (timestamped logfile) path
                               (format nil "~a:~a/lapback/" server *home*))
                 :environment env-vars :search t)))

(defun timestamped (path)
  (multiple-value-bind (seconds minutes hours date month year day dst-p tz)
      (get-decoded-time)
    (declare (ignore seconds minutes hours day dst-p tz))
    (format nil "--log-file=~a-~4d-~2,'0d-~2,'0d.log" path year month date)))

(defun main ()
  ;; (upload "/media/redlinux/home/redline/music"
  ;;         "/home/redline/docs/logs/backups/clockwork-webdev.com/music"
  ;;         "clockwork-webdev.com")
  (dolist (server *servers*)
    (let ((logfile (format nil "~a/~a/~a" *home* *log* server)))
      (sync "secrets" *secrets* logfile server)
      (sync "sessions" *sessions* logfile server)
      (dolist (dir *separate-dirs*)
        (upload dir (format nil "~a/~a" logfile (pathname-name dir)) server)))))

(main)
