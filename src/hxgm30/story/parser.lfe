(defmodule hxgm30.story.parser
  (export
   (file 1)
   (scan 1) (scan 2)
   (scan-links 1) (scan-links 2)
   (string 1)))

(defun file (filename)
  (scan (asciideck:parse_file filename)))

(defun string (data)
  (scan (asciideck:parse data)))

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
   ;;(io:format "Got list ...~n" '())
   (let ((acc-exits (maps:get #"exits" acc #m())))
     ;;(lfe_io:format "Got acc-exits: ~p~n" `(,acc-exits))
     (mset acc #"exits" (maps:merge acc-exits (scan-links exits-data)))))
  ((_ acc)
   acc))

(defun scan-links (data)
  (lists:foldl #'scan-links/2 #m() data))

(defun scan-links
  ((`#(list_item ,_ ,data ,_) acc)
   ;;(io:format "Got list_item ...~n" '())
   (scan-links data acc))
  ((`(#(paragraph ,_ (#(link #m(target ,file) ,label ,_)) ,_)) acc)
   ;;(io:format "Got paragraph ...~n" '())
   (let ((`(,id ,_) (re:split file "\\.")))
     ;;(io:format "Got <label, id>: <~p, ~p>~n" `(,label ,id))
     (maps:merge acc `#m(,label ,(binary_to_integer id)))))
  ((data acc)
   (lfe_io:format "Got unexpected data:~n~p~nacc:~p~n" `(,data ,acc))
   #m()))
