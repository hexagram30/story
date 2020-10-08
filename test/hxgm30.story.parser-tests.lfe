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
    