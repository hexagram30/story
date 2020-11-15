(defmodule hxgm30.story.parser
  (export
   (read 1)
   (parse-label 1)
   (scan 1) (scan 2)
   (scan-links 1) (scan-links 2)
   (string 1)
   (trim 1)
   (triml 1)
   (trimr 1)))

(defun read (filename)
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
  ((`#(section_title ,(= `#m(level 1) metadata) ,name ,_) acc)
   (mset acc 'last-section (mset metadata 'name name)))
  ((`#(paragraph ,_ ,desc ,_) (= `#m(last-section #m(name #"Content" #"default" #"true")) acc))
   (bombadil:assoc-in acc '(#"description" #"default") desc))
  ((`#(paragraph ,_ ,desc ,_) (= `#m(last-section #m(name #"Content" #"time" ,time)) acc))
   (io:format "Acc: ~p~n" `(,acc))
   (clj:-> acc
           (bombadil:assoc-in `(#"description" ,time) desc)
           (mset #"times" (++ (maps:get #"times" acc '()) (list time)))))
  ((`#(list ,_ ,exits-data ,_) (= `#m(last-section #m(name #"Exits")) acc))
   (let ((acc-exits (maps:get #"exits" acc '())))
     (mset acc #"exits" (lists:append acc-exits (scan-links exits-data)))))
  ((`#(list ,_ ,actions-data ,_) (= `#m(last-section #m(name #"Actions")) acc))
   (let ((acc-actions (maps:get #"actions" acc '())))
     (mset acc #"actions" (lists:append acc-actions (scan-links actions-data)))))
  ((`#(list ,_ ,topics-data ,_) (= `#m(last-section #m(name #"Topics")) acc))
   (let ((acc-topics (maps:get #"topics" acc '())))
     (mset acc #"topics" (lists:append acc-topics (scan-links topics-data)))))
  ((_ acc)
   acc))

(defun scan-links (data)
  (lists:foldl #'scan-links/2 '() data))

(defun scan-links
  ((`#(list_item ,_ ,data ,_) acc)
   ;;(io:format "Got list_item ...~n" '())
   (scan-links data acc))
  ((`(#(paragraph ,_ (#(link #m(target ,file) ,label ,_)) ,_)) acc)
   ;;(io:format "Got paragraph ...~n" '())
   (let ((id (filename:basename (filename:rootname file))))
     ;;(io:format "Got <label, id>: <~p, ~p>~n" `(,label ,id))
     (lists:append acc `(,(maps:merge (parse-label label)
                                      `#m(#"id" ,(binary_to_integer id)))))))
  ((data acc)
   (lfe_io:format "Got unexpected data:~n~p~nacc:~p~n" `(,data ,acc))
   '()))

(defun parse-label
  ((label) (when (is_binary label))
   (parse-label (re:split label "\\|")))
  ((`(,text ,command))
   `#m(#"text" ,(trim text)
       #"cmd" ,(trim command)))
  ((data)
    `#(error "Unexpected input:" ,data)))

(defun whitespace () "[\s\t\n\r]")

(defun trim (bitstring)
  (triml (trimr bitstring)))

(defun triml (bitstring)
  (case (re:replace bitstring
                    (++ "^" (whitespace) "+")
                    ""
                    '(global #(return binary)))
    ('() #"")
    ('(()) #"")
    (`(() . ,match) match)
    (nomatch nomatch)))

(defun trimr (bitstring)
  (case (re:replace bitstring
                    (++ (whitespace) "+$")
                    ""
                    '(global #(return binary)))
    ('() #"")
    ('(()) #"")
    (`(,match ,_) match)
    (nomatch nomatch)))
