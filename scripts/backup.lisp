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
;; Symlinks aren't followed, for example, in projects.

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((*standard-output* (make-broadcast-stream))
        (*error-output* (make-broadcast-stream)))
    (load "/home/redline/.sbclrc")
    (require 'external-program)))

(defpackage :backup
  (:use :cl)
  (:import-from :external-program :run))

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
  '("/home/redline/docs"
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
  (upload (bzip-it (tar-create (format nil "~a/~a.tar" *home* path)
                               (loop for path in files collecting
                                    (format nil "~a/~a" *home* path))))
          (format nil "~a/~a" logfile path) server)
  (delete-file (format nil "~a/~a.tar.bz2" *home* path)))

(defun upload (path logfile server)
  (if (string= "docs" (pathname-name path))
      (run "rsync" (list "-avz" "--delete" (timestamped logfile)
                         "--exclude" "'sources'" path
                         (format nil "~a:~a/lapback/" server *home*)))
      (run "rsync" (list "-avz" "--delete" (timestamped logfile)
                         path (format nil "~a:~a/lapback/" server *home*)))))

(defun timestamped (path)
  (multiple-value-bind (seconds minutes hours date month year day dst-p tz)
      (get-decoded-time)
    (declare (ignore seconds minutes hours day dst-p tz))
    (format nil "--log-file=~a-~4d-~2,'0d-~2,'0d.log" path year month date)))

(defun main ()
  (dolist (server *servers*)
    (let ((logfile (format nil "~a/~a/~a" *home* *log* server)))
      (sync "secrets" *secrets* logfile server)
      (sync "sessions" *sessions* logfile server)
      (dolist (dir *separate-dirs*)
        (upload dir (format nil "~a/~a" logfile (pathname-name dir)) server)))))

(main)
