(defmodule hxgm30.story.format.parser
  (export
   (parse-file 1)
   (scan 1) (scan 2)
   ))

(defun parse-file (filename)
  (let ((raw (asciideck:parse_file filename)))
    raw))

(defun scan (parsed)
  (scan parsed #m()))

(defun scan (parsed init)
  (maps:remove 'last-section
               (lists:foldl #'scan-block/2 init parsed)))

(defun scan-block
  ((`#(section_title ,(= `#m(level 0) metadata) ,name ,_) acc)
   (let* ((metadata (maps:without '(0 level) metadata))
          (acc (maps:merge acc metadata)))
     (mset acc #"name" name)))
  ((`#(section_title ,`#m(level 1) ,name ,_) acc)
   (mset acc 'last-section name))
  ((`#(paragraph ,_ ,desc ,_) (= `#m(last-section #"Default Content") acc))
   (mset acc #"description" desc))
  ((`#(list ,_ ,exits-data ,_) (= `#m(last-section #"Exits") acc))
   (let ((acc-exits (maps:get #"exits" acc #m())))
     (mset acc #"exits" (maps:merge acc-exits (scan-links exits-data)))))
  ((_ acc)
   acc))

(defun scan-links
  ((`#(list_item ,_ ,data ,_))
   (scan-links data))
  ((`#(paragraph ,_ (#(link #m(target ,file) ,label ,_)) ,_))
   (let ((`(,id ,_) (re:split file "\\.")))
     `#m(,label ,(binary_to_integer id))))
  ((_) #m()))

(defun metadata-filter
  ((`#(section_title ,(= `#m(level 0) metadata) ,_ ,_))
   `#(true ,metadata))
  ((_)
   'false))

(defun name-filter
  ((`#(section_title ,`#m(level 0) ,name ,_))
   `#(true ,name))
  ((_)
   'false))

(defun desc-filter
  ((`#(section_title ,`#m(level 1) ,name ,_))
   `#(true ,name))
  ((_)
   'false))

(defun metadata
  (('())
   #m())
  ((parsed)
   (let ((raw (car (lists:filtermap #'metadata-filter/1 parsed))))
     (maps:without '(0 level) raw))))

(defun name (parsed)
  (car (lists:filtermap #'name-filter/1 parsed)))
