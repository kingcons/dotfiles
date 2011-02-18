;; Randomfile by Brit Butler <redline6561@gmail.com>
;; TODO:
;; Have restart options of picking a different file or path or exiting for play.
;; -- Should handle default path or supplied path.
;; Add sane option handling. I.e. order doesn't matter.

(defpackage :randomfile
  (:use :cl)
  (:import-from :cl-fad :walk-directory :directory-pathname-p)
  (:import-from :external-program :start))

(in-package :randomfile)

;; Player types and args
(defvar *video-player* "smplayer")
(defvar *vp-args* '("-fullscreen"))
(defvar *document-viewer* "evince")
(defvar *dv-args* '())
(defvar *mp3-player* "mpg123")
(defvar *ogg-player* "ogg123")
(defvar *ap-args* '())
(defvar *image-viewer* "feh")
(defvar *iv-args* '("--bg-scale"))

(defmacro define-ext-test (type extensions)
  `(defun ,type (file)
     (let ((ext (pathname-type (first file))))
       (member ext ,extensions :test #'equal))))

(define-ext-test video-p '("avi" "mp4" "mov" "flv" "m4v" "mpg" "mkv" "ogm" "ogv"))
(define-ext-test docs-p '("djvu" "pdf" "ps" "dvi"))
(define-ext-test mp3-p '("mp3"))
(define-ext-test ogg-p '("ogg"))
(define-ext-test image-p '("png" "jpg"))

(defun play (path)
  (cond ((video-p path)
         (start *video-player* (append *vp-args* path)))
        ((docs-p path)
         (start *document-viewer* (append *dv-args* path)))
        ((mp3-p path)
         (start *mp3-player* (append *ap-args* path)))
        ((ogg-p path)
         (start *ogg-player* (append *ap-args* path)))
        ((image-p path)
         (start *image-viewer* (append *iv-args* path)))
        (t (error "Not implemented yet. File was ~A.~%" path))))

(defun choose-file (&optional (path (getcwd)))
  (let ((results nil))
    (walk-directory path
                    #'(lambda (path)
                        (when (not (directory-pathname-p path))
                          (push (namestring path) results))))
    (setf *random-state* (make-random-state t))
    (list (nth (random (length results)) results))))

(defun display-help ()
  (format t "~
Usage:
  randomfile         # play a random media file in this directory or its subdirs
  randomfile -n      # print a random file underneath $PWD. handy for pipes
  randomfile -p PATH # play a random media file in PATH or its subdirectories
  randomfile -h      # print this help message. :)~%"))

;;;; portability
(defun getargs ()
  #+sbcl(rest sb-ext:*posix-argv*)
  #+ecl(rest (ext:command-args))
  #+ccl(rest (ccl::command-line-arguments))
  #-(or sbcl ecl ccl)(error "not implemented yet"))

(defun getcwd ()
  #+sbcl(sb-posix:getcwd)
  #+ecl(ext:getcwd)
  #+ccl(ccl::current-directory-name)
  #-(or sbcl ecl ccl)(error "not implemented yet"))

(defun main ()
  (let* ((args (getargs))
         (option (first args))
         (arg (second args)))
    (cond ((null option)
           (play (choose-file)))
          ((string= "-n" option)
           (format t "~A~%" (first (choose-file))))
          ((string= "-h" option)
           (display-help))
          ((string= "-p" option)
           (play (choose-file arg)))
          (t (display-help)))))

#+ecl(main)
