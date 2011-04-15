;; The world's greatest worst lisp backup script.
;; And yes, just using a shell script would probably make way more sense.

;; Backup space breakdown:
;; ~/docs is ~8GB. ~4GB without "sources".
;; /media/redlinux/~/images is ~1G.
;; ~/projects is ~500mb.
;; ~5-6 gigs total.
;; Thank God for rsync, http://cs.anu.edu.au/techreports/1996/TR-CS-96-05.pdf
;; ~$5 a month to keep 30G of music on S3

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((*standard-output* (make-broadcast-stream))
        (*error-output* (make-broadcast-stream)))
    (ql:quickload '(external-program split-sequence zs3 cl-fad))))

(defpackage :backup
  (:use :cl :zs3)
  (:import-from :external-program #:run)
  (:import-from :split-sequence #:split-sequence)
  (:import-from :cl-fad #:walk-directory))

(in-package :backup)

;; TODO:
;; optionally set bucket, upload-dir and public-p via cli args.
;; optionally do s3sync, uploads or both via command line args.
;; should be able to force s3 regardless of day...
;; keep an index of what's on s3? use cl-store and keep in sync.
;; generate browseable html?
;; handle duplicates on S3 by deleting them if found during cache creation?

;; portability
(defun getargv ()
  #+sbcl sb-ext:*posix-argv*
  #+ccl ccl:*command-line-argument-list*
  #+ecl (ext:command-args)
  #-(or sbcl ccl ecl) (error "no argv"))

(defun getenv (name)
  #+sbcl (sb-posix:getenv name)
  #+ccl (ccl:getenv name)
  #+ecl (ext:getenv name)
  #-(or sbcl ccl ecl) (error "no getenv"))

(defun quit ()
  #+sbcl (sb-ext:quit)
  #+ccl (ccl:quit)
  #+ecl (ext:quit)
  #-(or sbcl ccl ecl) (error "no quit"))

; (defvar *use-ssl* t)
(defvar *home* (getenv "HOME"))
(defvar *log* "docs/logs/backups")
(defparameter *bucket* "music.redlinernotes.com")
(defparameter *upload-dir* "/media/redlinux/home/redline/music/")
(defparameter *public-p* nil)

(defparameter *key-cache* (make-hash-table :test #'equal)
  "A cache of keys in a given bucket hashed by etag.")

(defparameter *credentials*
  (file-credentials (concatenate 'string *home* "/.aws"))
  "The credentials to authenticate with Amazon Web Services.
Stored in a file with the access key on the first line
and the secret key on the second.")

(defvar *sessions*
  '(".mozilla/firefox/7nnhqw2r.default/sessionstore.js"
    ".config/chromium/Default/Current Session"
    ".config/chromium/Default/Current Tabs"
    ".conkeror.mozdev.org/conkeror/sk3mzb89.default/sessions/auto-save"))

(defvar *secrets*
  '(".ssh/"
    ".gnupg/"
    ".aws"))

(defvar *separate-dirs*
  ;; My ~/{docs,images,projects} are symlinks to an old partition.
  '("/media/redlinux/home/redline/docs"
    "/media/redlinux/home/redline/images"
    "/media/redlinux/home/redline/projects"))

(defvar *servers*
  '("redlinernotes.com"
    "clockwork-webdev.com"))

(defun stale-keys (&key cache)
  (loop for key being the hash-values in cache collecting key))

(defun s3-sync (filepath &key bucket dir public-p cache output)
  (flet ((compute-key (namestring)
           (subseq namestring (length (namestring (truename dir))))))
    (let* ((etag (file-etag filepath))
           (namestring (namestring filepath))
           (key (compute-key namestring)))
      (when output
        (format t "~C" (code-char 13))
        (format t "Current File: ~76A" (if (> (length key) 75)
                                           (subseq key 0 75)
                                           key))
        (force-output))
      (if (gethash etag cache)
          (remhash etag cache)
          (put-file filepath bucket key :public public-p
                    :content-type
                    (if (string= (pathname-type filepath) "mp3")
                        "audio/mpeg"
                        "binary/octet-stream"))))))

(defun dir->s3 (dir &key bucket cache output public-p)
  (walk-directory dir (lambda (file)
                        (s3-sync file :cache cache :dir dir
                                 :bucket bucket :output output
                                 :public-p public-p))))

(defun tar-create (tar paths)
  (run "tar" `("-cvf" ,tar ,@paths))
  tar)

(defun bzip-it (path)
  (run "bzip2" (list path))
  (format nil "~a.bz2" path))

(defun timestamped (path)
  (multiple-value-bind (seconds minutes hours date month year day dst-p tz)
      (get-decoded-time)
    (declare (ignore seconds minutes hours day dst-p tz))
    (format nil "--log-file=~a-~4d-~2,'0d-~2,'0d.log" path year month date)))

(defun upload (path logfile server)
  (let ((env-vars (with-open-file (in (format nil "~a/.ssh/agent.env" *home*))
                    (let ((result (list (split-sequence #\= (read-line in))
                                        (split-sequence #\= (read-line in)))))
                      (pairlis (mapcar #'first result)
                               (mapcar #'second result))))))
    (format t "Starting rsync for ~A~%" path)
    (run "rsync" (list "-avz" "--delete" (timestamped logfile) path
                       (format nil "~a:~a/lapback/" server *home*))
         :environment env-vars :search t :replace-environment-p t)))

(defun sync (path files logfile server)
  (format t "Syncing ~a to ~a...~%" path server)
  (upload (bzip-it (tar-create (format nil "~a/~a.tar" *home* path)
                               (loop for path in files collecting
                                    (format nil "~a/~a" *home* path))))
          (format nil "~a/~a" logfile path) server)
  (delete-file (format nil "~a/~a.tar.bz2" *home* path))
  (format t "Transfer complete. ~a:~a is backed up.~%" path server))

(defun main (&key (cache *key-cache*) (bucket *bucket*)
             (dir *upload-dir*))
  ;; Only run Tue,Thu,Sat.
  (when (oddp (nth-value 6 (get-decoded-time)))
    (format t "Retrieving keys from ~A...~%" bucket)
    (let ((keys (all-keys bucket)))
      (format t "Caching keys.~%") ; princ?
      (loop for key across keys do (setf (gethash (etag key) cache) key))
      (format t "~A keys cached.~%Beginning sync...~%" (hash-table-count cache))
      (dir->s3 dir :output t :bucket bucket :cache cache)
      (format t "~%Upload of new and modified files complete.~%")
      (format t "Checking for stale keys to delete...~%")
      (when (stale-keys :cache cache)
        (format t "~D keys left to delete.~%" (hash-table-count cache))
        (delete-objects (stale-keys) bucket)))
    (format t "Sync to ~S S3 bucket complete.~%" bucket))
  (dolist (server *servers*)
    (let ((logfile (format nil "~a/~a/~a" *home* *log* server)))
      (sync "secrets" *secrets* logfile server)
      (sync "sessions" *sessions* logfile server)
      (dolist (dir *separate-dirs*)
        (upload dir (format nil "~a/~a" logfile (pathname-name dir)) server)))))

(main)
(quit)
