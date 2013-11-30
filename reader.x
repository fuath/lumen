;; -*- mode: lisp -*-

(defvar delimiters (make-set "(" ")" ";" "\n"))
(defvar whitespace (make-set " " "\t" "\n"))

(defun make-stream (str)
  (table pos 0 string str len (length str)))

(defun peek-char (s)
  (if (< s.pos s.len) (char s.string s.pos)))

(defun read-char (s)
  (local c (peek-char s))
  (if c (do (set s.pos (+ s.pos 1)) c)))

(defun skip-non-code (s)
  (while true
    (local c (peek-char s))
    (if (not c) break
        (get whitespace c) (read-char s)
	(= c ";")
	(do (while (and c (not (= c "\n")))
	      (set c (read-char s)))
	    (skip-non-code s))
      break)))

(defvar read-table (table))
(defvar eof (table))

(defmacro define-reader ((char stream) body...)
  `(set (get read-table ,char) (lambda (,stream) ,@body)))

(define-reader ("" s) ; atom
  (local str "")
  (while true
    (local c (peek-char s))
    (if (and c (and (not (get whitespace c))
		    (not (get delimiters c))))
	(do (cat! str c)
	    (read-char s))
      break))
  (local n (parse-number str))
  (if (not (= n nil)) n
      (= str "true") true
      (= str "false") false
    str))

(define-reader ("(" s)
  (read-char s)
  (local l ())
  (while true
    (skip-non-code s)
    (local c (peek-char s))
    (if (and c (not (= c ")"))) (push l (read s))
        c (do (read-char s) break) ; )
      (error (cat "Expected ) at " s.pos))))
  l)

(define-reader (")" s)
  (error (cat "Unexpected ) at " s.pos)))

(define-reader ("\"" s)
  (read-char s)
  (local str "\"")
  (while true
    (local c (peek-char s))
    (if (and c (not (= c "\"")))
	(do (if (= c "\\") (cat! str (read-char s)))
	    (cat! str (read-char s)))
        c (do (read-char s) break) ; "
      (error (cat "Expected \" at " s.pos))))
  (cat str "\""))

(define-reader ("'" s)
  (read-char s)
  (list 'quote (read s)))

(define-reader ("`" s)
  (read-char s)
  (list 'quasiquote (read s)))

(define-reader ("," s)
  (read-char s)
  (if (= (peek-char s) "@")
      (do (read-char s)
	  (list 'unquote-splicing (read s)))
    (list 'unquote (read s))))

(defun read (s)
  (skip-non-code s)
  (local c (peek-char s))
  (if c
      ((or (get read-table c)
	   (get read-table ""))
       s)
    eof))

(defun read-from-string (str) (read (make-stream str)))
