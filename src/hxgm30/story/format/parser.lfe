(defmodule hxgm30.story.format.parser
  (export
   (parse-file 1)
   (metadata 1)
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
   (mset acc #"exits" (scan exits-data #m(last-section #"Exits"))))
  ((`#(list_item ,_ ,exit-data ,_) (= `#m(last-section #"Exits") acc))
    (scan exit-data acc))
  ((`#(paragraph ,_ (#(link #m(target ,file) ,dir ,_)) ,_) (= `#m(last-section #"Exits") acc))
   (let ((`(,id ,_ext) (re:split file "\\.")))
     (maps:merge acc `#m(,dir ,(binary_to_integer id)))))
  ((_ acc)
   acc))

;; XXX the above still isn't there yet ... not getting all the exits

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
