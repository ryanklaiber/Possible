;;;;intial pre-processing requires the manual removal of all quotation marks from the text, as they would prevent operations on the whole text as one string. Secondary processing is on strings and tertiary on lists. 

;;not to be used if pre-processed with quote removal. Would probably replace the "(" and ")" in concatenation with "|" and "|" so that it could be concatenated with all of the other (string symbol) symbols, then have the car taken of ;;the list to return one string with | symbols to mark quotations instead of " symbols. Upon conversion to a list, the original quote would be treated as one symbol.  
(defun no-quotes (lst)
           (setf (nth (position (find-if #'stringp lst) lst :test #'equal) lst)(concatenate 'string "(" (nth (position (find-if #'stringp lst) lst :test #'equal) lst)))
           (setf (nth (position (find-if #'stringp lst) lst :test #'equal) lst)(reverse (concatenate 'string ")" (reverse (nth (position (find-if #'stringp lst) lst :test #'equal) lst)))))
           (setf (nth (position (find-if #'stringp lst) lst :test #'equal) lst)(read-from-string (nth (position (find-if #'stringp lst) lst :test #'equal) lst))))

;;not to be used if pre-processed with quote removal
(defun rm-quotes (lst)
           (if (find-if #'stringp lst) (progn (no-quotes lst)
                                              (rm-quotes lst)) lst))


;;;converting string to list functions here


(defmacro listing (stri)
           `(setf ,stri (lister ,stri)))

(defun lister (stri)
"turns a string into a list"
           (multiple-value-bind (lst)
               (read-from-string (periparen 0 1 stri))
             lst))

(defun periparen (start end stri)
"replaces periods with closed and then open parentheses"
  (cond ((equal (length stri) end) (progn (setf (subseq stri start end) ")")
                                          (setf stri (reverse (concatenate 'string ")" (reverse stri))))
                                          (setf stri (concatenate 'string "((" stri))))
        ((equal (subseq stri start end) ".") (progn (setf (subseq stri start end) ")")
                                                    (setf (subseq stri (+ 1 start) (+ 1 end)) "(")
                                                    (periparen (+ 2 start) (+ 2 end) stri)))
        (t (periparen (+ 1 start) (+ 1 end) stri))))

;;;string-manipulating functions here



;;;list-manipulating functions here

