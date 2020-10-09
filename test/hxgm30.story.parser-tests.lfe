(defmodule hxgm30.story.parser-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

(defun test-file () "priv/testing/simple-area.adoc")

(deftest parse-file
  (let ((data (hxgm30.story.parser:file (test-file))))
    (is-equal #"1" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"The MUSH Room" (mref data #"name"))
    (is-equal #"You are in a large, low-lit, warm room. The floor and walls are soft but firm, with a bit of a bounce. There is a distinctive odor about the place." (mref data #"description"))
    (is-equal #m(#"inwards" 2 #"down" 3) (mref data #"exits"))))

(defun test-string ()
  (++ "[id=1, type=area]\n= The MUSH Room\n\n== Default Content\n\nYou are in a large, low-lit, warm room. The floor and walls are soft but firm,\nwith a bit of a bounce. There is a distinctive odor about the place.\n\n== Exits\n\n* link:2.adoc[inwards]\n* link:3.adoc[down]\n\n== Items\n\n\n== Media\n"))

(deftest parse-string
  (let ((data (hxgm30.story.parser:string (test-string))))
    (is-equal #"1" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"The MUSH Room" (mref data #"name"))
    (is-equal #"You are in a large, low-lit, warm room. The floor and walls are soft but firm, with a bit of a bounce. There is a distinctive odor about the place." (mref data #"description"))
    (is-equal #m(#"inwards" 2 #"down" 3) (mref data #"exits"))))

(defun test-bitstring ()
  (++ #"[id=1, type=area]\n= The MUSH Room\n\n== Default Content\n\nYou are in a large, low-lit, warm room. The floor and walls are soft but firm,\nwith a bit of a bounce. There is a distinctive odor about the place.\n\n== Exits\n\n* link:2.adoc[inwards]\n* link:3.adoc[down]\n\n== Items\n\n\n== Media\n"))

(deftest parse-bitstring
  (let ((data (hxgm30.story.parser:string (test-bitstring))))
    (is-equal #"1" (mref data #"id"))
    (is-equal #"area" (mref data #"type"))
    (is-equal #"The MUSH Room" (mref data #"name"))
    (is-equal #"You are in a large, low-lit, warm room. The floor and walls are soft but firm, with a bit of a bounce. There is a distinctive odor about the place." (mref data #"description"))
    (is-equal #m(#"inwards" 2 #"down" 3) (mref data #"exits"))))
