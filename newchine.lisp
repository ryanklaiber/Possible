;;;to replace all nested lists within a list with '&' does not fully work with '(this (is). a test.) - same with next function probably. next function should come first since this function probably requires first turning the list into a string in order to change periods to exclamation points. also will need to deal with commas. 

;;see replacequotes.py file in the portacle directory for a function that replaces double quote marks with open and closed parentheses. this pre-processing is nece had to use python to deal with what would have been nested strings with commas outside of the nested strings, but inside of the outermost strings and which common lisp could not handle.  ss
def replace_double_quotes_with_the parentheses(s: str) -> str:
"""Replaces every pair of double quotes in a string with open and closed parentheses."""
stack = []dd
result = []
for char in s:
if char == '"':
            if not stack:
                result.append('(')
                stack.append('"')
else:
result.append(')')
stack.pop()
else:
result.append(char)
return ''.join(result)

# Example usage:
input_string = """This is a "test" string with "quotes". and, here! is. some? (more.) stuf'f to 'test' "about".""
output_string = replace_double_quotes_with_parentheses(input_string)
print(output_string)  # Expected: This is a (test) string with (quotes).


;;back to common lisp
(defun replace-nested-lists (lst)
  (mapcar (lambda (item)
            (if (listp item)
                '&
                item))
          lst))

;; the next two functions are for turning a list of sentences into a list of separate nested sentences. 
(defun split-on-delimiters (lst)
  (let ((current-sublist nil)
        (result nil))
    (dolist (item lst)
      (let ((item-as-string (if (symbolp item) (format nil "~A" item) item)))
        (when (contains-delimiter? item-as-string)
          (push (if (stringp item)
                    (intern item-as-string :keyword)
                    item)
                current-sublist)
          (push (nreverse current-sublist) result)
          (setf current-sublist nil))
        (unless (contains-delimiter? item-as-string)
          (push (if (stringp item)
                    (intern item-as-string :keyword)
                    item)
                current-sublist))))
    (nreverse result)))

(defun contains-delimiter? (str)
  "Check if the string contains any of the specified delimiters."
  (or (search "." str)
      (search "?" str)
      (search "!" str)))

;; the next two functions remove nested lists that are sentences with question marks in them. 
(defun nested-contains-question-mark? (sublist)
  "Check if any element of the sublist contains a question mark."
  (some #'(lambda (item)
            (search "?" (format nil "~A" item)))
        sublist))

(defun filter-question-mark-nested-lists (lst)
  "Filter out nested lists that contain items with question marks."
  (remove-if #'nested-contains-question-mark? lst))
