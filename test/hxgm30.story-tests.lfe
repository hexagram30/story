(defmodule hxgm30.story-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

;;; -----------
;;; library API
;;; -----------

(deftest my-fun
  (is-equal 'hello-world (hxgm30.story:my-fun)))
