(defmodule hxgm30.story.parser-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest parse-basic-area
  (let* ((test-file "priv/testing/area.adoc")
         (data (hxgm30.story.parser:read test-file)))
    (is-equal #"42" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"true" (mref data #"attribute-sensitive"))
    (is-equal #"Cavern Great Room" (mref data #"name"))
    (is-equal #"You are in a large, almost completely dark cavern."
              (clj:get-in data '(#"description" #"default")))
    (is-equal '(#m(#"id" 101 #"cmd" #"north" #"text" #"cavern exit")
                  #m(#"id" 301 #"cmd" #"down" #"text" #"descend deeper"))
              (mref data #"exits"))))

(deftestskip parse-area-items
  'tbd)

(deftestskip parse-area-occupants
  'tbd)

(deftest parse-time-sensitive-area
  (let* ((test-file "priv/testing/area.adoc")
         (data (hxgm30.story.parser:read test-file)))
    (is-equal #"true" (mref data #"time-sensitive"))
    (is-equal #"true" (mref data #"append-content"))
    (is-equal '(#"day" #"night") (mref data #"times"))
    (is-equal #"You are in a large, almost completely dark cavern."
              (clj:get-in data '(#"description" #"default")))
    (is-equal #"There is one slight hint of light to the north which you believe to be the exit from this system of caves."
              (clj:get-in data '(#"description" #"day")))
    (is-equal #"In fact, no \"almost\" about it. It is pitch black in here."
              (clj:get-in data '(#"description" #"night")))))    

(deftestskip parse-character-sensitive-area
  'tbd)

(deftest parse-book
  (let* ((test-file "priv/testing/book.adoc")
         (data (hxgm30.story.parser:read test-file)))
    (is-equal #"100" (mref data #"id"))
    (is-equal #"book" (mref data #"type"))
    (is-equal #"The Mykonomicon" (mref data #"name"))
    (is-equal '(#m(#"cmd" #"open" #"id" 2 #"text" #"open the book"))
              (mref data #"actions"))))

(deftest parse-npc
  (let* ((test-file "priv/testing/npc-guide.adoc")
         (data (hxgm30.story.parser:read test-file)))
    (is-equal #"200" (mref data #"id"))
    (is-equal #"npc" (mref data #"type"))
    (is-equal #"guide" (mref data #"role"))
    (is-equal #"Myka" (mref data #"name"))
    (is-equal '(#m(#"cmd" #"where" #"id" 1 #"text" #"\"Where are we?\"")
                #m(#"cmd" #"what" #"id" 2 #"text" #"\"What is this place?\"")
                #m(#"cmd" #"myka" #"id" 3 #"text" #"\"Tell me about yourself ...\""))
              (mref data #"topics"))))

(deftest parse-file
  (let* ((test-file "priv/testing/simple-area.adoc")
         (data (hxgm30.story.parser:read test-file)))
    (is-equal #"1" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"The MUSH Room" (mref data #"name"))
    (is-equal (desc)
              (clj:get-in data '(#"description" #"default")))
    (is-equal '(#m(#"id" 2 #"cmd" #"inwards" #"text" #"Head toward the center")
                  #m(#"id" 3 #"cmd" #"down" #"text" #"Climb through the trap door"))
              (mref data #"exits"))))

(deftest parse-string
  (let ((data (hxgm30.story.parser:string (test-string))))
    (is-equal #"1" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"The MUSH Room" (mref data #"name"))
    (is-equal (desc)
              (clj:get-in data '(#"description" #"default")))
    (is-equal '(#m(#"id" 2 #"cmd" #"inwards" #"text" #"Head toward the center")
                  #m(#"id" 3 #"cmd" #"down" #"text" #"Climb through the trap door"))
              (mref data #"exits"))))

(deftest parse-bitstring
  (let ((data (hxgm30.story.parser:string (test-bitstring))))
    (is-equal #"1" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"The MUSH Room" (mref data #"name"))
    (is-equal (desc)
              (clj:get-in data '(#"description" #"default")))
    (is-equal '(#m(#"id" 2 #"cmd" #"inwards" #"text" #"Head toward the center")
                  #m(#"id" 3 #"cmd" #"down" #"text" #"Climb through the trap door"))
              (mref data #"exits"))))

(deftest parse-label
  (let* ((label #"\"Tell me about yourself ...\" | myka")
         (parsed (hxgm30.story.parser:parse-label label)))
    (is-equal #"\"Tell me about yourself ...\"" (mref parsed #"text"))
    (is-equal #"myka" (mref parsed #"cmd"))))

(deftest triml
  ;; strings
  (is-equal #"" (hxgm30.story.parser:triml ""))
  (is-equal #"" (hxgm30.story.parser:triml " \t \n \r \r\n"))
  (is-equal #"some thing \t " (hxgm30.story.parser:triml " \r\n   some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:triml " \r\n   some thing"))
  (is-equal #"some thing \t " (hxgm30.story.parser:triml "some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:triml "some thing"))
  ;; bitstrings
  (is-equal #"" (hxgm30.story.parser:triml #""))
  (is-equal #"" (hxgm30.story.parser:triml #" \t \n \r \r\n"))
  (is-equal #"some thing \t " (hxgm30.story.parser:triml #" \r\n   some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:triml #" \r\n   some thing"))
  (is-equal #"some thing \t " (hxgm30.story.parser:triml #"some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:triml #"some thing")))

(deftest trimr
  ;; string
  (is-equal #"" (hxgm30.story.parser:trimr ""))
  (is-equal #"" (hxgm30.story.parser:trimr " \t \n \r \r\n"))
  (is-equal #" \r\n   some thing" (hxgm30.story.parser:trimr " \r\n   some thing \t "))
  (is-equal #" \r\n   some thing" (hxgm30.story.parser:trimr " \r\n   some thing"))
  (is-equal #"some thing" (hxgm30.story.parser:trimr "some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:trimr "some thing"))
  ;; bitstring
  (is-equal #"" (hxgm30.story.parser:trimr #""))
  (is-equal #"" (hxgm30.story.parser:trimr #" \t \n \r \r\n"))
  (is-equal #" \r\n   some thing" (hxgm30.story.parser:trimr #" \r\n   some thing \t "))
  (is-equal #" \r\n   some thing" (hxgm30.story.parser:trimr #" \r\n   some thing"))
  (is-equal #"some thing" (hxgm30.story.parser:trimr #"some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:trimr #"some thing")))

(deftest trim
  ;; string
  (is-equal #"" (hxgm30.story.parser:trim ""))
  (is-equal #"" (hxgm30.story.parser:trim " \t \n \r \r\n"))
  (is-equal #"some thing" (hxgm30.story.parser:trim " \r\n   some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:trim " \r\n   some thing"))
  (is-equal #"some thing" (hxgm30.story.parser:trim "some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:trim "some thing"))
  ;; bitstring
  (is-equal #"" (hxgm30.story.parser:trim ""))
  (is-equal #"" (hxgm30.story.parser:trim " \t \n \r \r\n"))
  (is-equal #"some thing" (hxgm30.story.parser:trim " \r\n   some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:trim " \r\n   some thing"))
  (is-equal #"some thing" (hxgm30.story.parser:trim "some thing \t "))
  (is-equal #"some thing" (hxgm30.story.parser:trim "some thing")))

;;; Test data

(defun test-string ()
  "[id=1, type=area]\n= The MUSH Room\n\n[default=true]\n== Content\n\nYou are in a large, low-lit, warm room. The floor and walls are soft but firm,\nwith a bit of a bounce. There is a distinctive odor about the place. The only\nfeatures of interest seem to be some sort of structure in the center of the\nroom. Oh, and the trap down next to you.\n\n== Exits\n\n* link:areas/starting-zones/faction-1/2.adoc[Head toward the center | inwards]\n* link:areas/starting-zones/faction-1/3.adoc[Climb through the trap door | down]\n")

(defun test-bitstring ()
  #"[id=1, type=area]\n= The MUSH Room\n\n[default=true]\n== Content\n\nYou are in a large, low-lit, warm room. The floor and walls are soft but firm,\nwith a bit of a bounce. There is a distinctive odor about the place. The only\nfeatures of interest seem to be some sort of structure in the center of the\nroom. Oh, and the trap down next to you.\n\n== Exits\n\n* link:areas/starting-zones/faction-1/2.adoc[Head toward the center | inwards]\n* link:areas/starting-zones/faction-1/3.adoc[Climb through the trap door | down]\n")

(defun desc ()
  #"You are in a large, low-lit, warm room. The floor and walls are soft but firm, with a bit of a bounce. There is a distinctive odor about the place. The only features of interest seem to be some sort of structure in the center of the room. Oh, and the trap down next to you.")