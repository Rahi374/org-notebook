;;; org-notebook.el --- A package to ease the use of org-mode as a notebook  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Paul Elder

;; Author: Paul Elder <paul.elder@amanokami.net>
;; Keywords: convenience, tools
;; Version: 1.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The main function is org-notebook-insert-image
;; Bind this to a convenient key combination
;;
;; There is also org-notebook-new-notebook
;; This creates a directory with the name of the
;; notebook you provide, and then creates
;; a notebook.org file and an img directory in it.
;; It populates the notebook.org file with org
;; headers, asking you for a title only since
;; the author, email, and language are extracted
;; automatically.
;;
;; For customization there is:
;;
;; org-notebook-drawing-program
;; By default this is set to kolourpaint
;; feel free to change it to whatever you want
;;
;; org-notebook-image-type
;; By default this is set to png
;; feel free to change it to whatever you want
;; although org should be able to display it
;;
;; org-notebook-language
;; By default this is set to en
;; feel free to change it if you use a different
;; language for your notebook

;;; Code:

(require 'org)
(require 'ido)

(defgroup org-notebook nil
  "Ease the use of org-mode as a notebook"
  :group 'convenience
  :group 'tools
  :link '(emacs-library-link :tag "Lisp File" "org-notebook.el")
  )

(defcustom org-notebook-drawing-program "kolourpaint"
  "Drawing program to be used"
  :type 'string
  :group 'org-notebook
  )

(defcustom org-notebook-image-type "png"
  "Image type to be used"
  :type 'string
  :group 'org-notebook
  )

(defcustom org-notebook-language "en"
  "Language that the notebook will be in, mostly just for the org header"
  :type 'string
  :group 'org-notebook
  )

(defun org-notebook-new-notebook ()
  "Create a new org-notebook notebook"
  (interactive)
  (setq org-notebook-filepath (ido-read-file-name "Notebook name: " default-directory))
  (make-directory org-notebook-filepath)
  (make-directory (concat org-notebook-filepath "/img"))
  (find-file (concat org-notebook-filepath "/notebook.org"))
  (insert (concat
	    (concat "#+TITLE:     " (read-from-minibuffer "Title: " (first (last (split-string org-notebook-filepath "/")))))
	    (concat "#+AUTHOR:    " (user-full-name))
	    (concat "#+EMAIL:     " user-mail-address)
	    (concat "#+LANGUAGE:  " org-notebook-language)
	    )
    )
  )

(defun org-notebook-insert-image ()
  "Insert an image with auto-completion for the next image name and open the drawing program"
  (interactive)
  (setq org-notebook-image-filepath
    (concat
      "./img/"
      (read-from-minibuffer "Filename: " (concat "img"
					   (number-to-string
					     (+
					       (string-to-number
						 (substring
						   (first
						     (split-string
						       (first (last
								(sort
								  (or
								    (cdr (cdr (directory-files "./img")))
								    (cons (concat "img0." org-notebook-image-type) '()) )
								  'dictionary-lessp)
								))
						       (concat "." org-notebook-image-type))
						     )
						   3)
						 )
					       1)
					     )
					   ".png"
					   )
	)))
  (insert (concat "[[" org-notebook-image-filepath "]]"))
  (start-process "org-notebook-drawing" nil org-notebook-drawing-program org-notebook-image-filepath)
  )

;; The following is code for a custom comparison to allow for natural sorting to extract the guessed next-image name
;; Source: http://stackoverflow.com/questions/1942045/natural-order-sort-for-emacs-lisp

(defun dictionary-lessp (str1 str2)
  "return t if STR1 is < STR2 when doing a dictionary compare
(splitting the string at numbers and doing numeric compare with them)"
  (let ((str1-components (dict-split str1))
        (str2-components (dict-split str2)))
    (dict-lessp str1-components str2-components)))

(defun dict-lessp (slist1 slist2)
  "compare the two lists of strings & numbers"
  (cond ((null slist1)
         (not (null slist2)))
        ((null slist2)
         nil)
        ((and (numberp (car slist1))
              (stringp (car slist2)))
         t)
        ((and (numberp (car slist2))
              (stringp (car slist1)))
         nil)
        ((and (numberp (car slist1))
              (numberp (car slist2)))
         (or (< (car slist1) (car slist2))
             (and (= (car slist1) (car slist2))
                  (dict-lessp (cdr slist1) (cdr slist2)))))
        (t
         (or (string-lessp (car slist1) (car slist2))
             (and (string-equal (car slist1) (car slist2))
                  (dict-lessp (cdr slist1) (cdr slist2)))))))

(defun dict-split (str)
  "split a string into a list of number and non-number components"
  (save-match-data 
    (let ((res nil))
      (while (and str (not (string-equal "" str)))
        (let ((p (string-match "[0-9]*\\.?[0-9]+" str)))
          (cond ((null p)
                 (setq res (cons str res))
                 (setq str nil))
                ((= p 0)
                 (setq res (cons (string-to-number (match-string 0 str)) res))
                 (setq str (substring str (match-end 0))))
                (t
                 (setq res (cons (substring str 0 (match-beginning 0)) res))
                 (setq str (substring str (match-beginning 0)))))))
      (reverse res))))

(provide 'org-notebook)
;;; org-notebook.el ends here
