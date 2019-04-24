//creates the replace-all function
(defun replace-all (string part replacement &key (test #'char=))
"Returns a new string in which all the occurences of the part 
is replaced with replacement."
    (with-output-to-string (out)
      (loop with part-length = (length part)
            for old-pos = 0 then (+ pos part-length)
            for pos = (search part string
                              :start2 old-pos
                              :test test)
            do (write-string string out
                             :start old-pos
                             :end (or pos (length string)))
            when pos do (write-string replacement out)
            while pos))) 

//uses replace all function to alter source data
(defun bip1 ()
"bip is an acronym for Basic Input Processing. It changes the original string information in the following ways: 1. It puts parentheses in between sentences. 2. Abbreviations are expanded. 3. Same meaning phrases are replaced - and shortened if possible. 4. Synonyms are replaced."
  (with-open-file (stream "C:/Users/Klaiber/Desktop/Lenovo/Programs/Installed Programs/lispbox-0.7/input.data") /data source file varies
    (defvar input-data (read stream)))
 (setf input-data (replace-all input-data "test" "winning"))
 (setf input-data (replace-all input-data "input" "super"))
 (setf input-data (replace-all input-data "data" "awesome"))
 (setf input-data (replace-all input-data "file" "program"))
(read-from-string input-data))

