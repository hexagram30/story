(defmodule hxgm30.story.format.parser
  (export
   (parse-file 1)
   ))

(defun parse-file (filename)
  (let ((raw ((asciideck:parse_file filename))))
    ))

(defun scan-parsed (blocks)
  (scan-parsed blocks '()))

(defun scan-parsed
  (('() _ acc)
   (lists:reverse acc))
  ((`(,(= `#(section_title ,metadata ,content ,_position) block) . ,rest) blocks acc)
    (lists:append `(,blocks) acc)
    (scan-parsed `(#m(section #(title ,block)
  (((= `#(,type ,metadata ,content ,_position) orig) acc)
    )