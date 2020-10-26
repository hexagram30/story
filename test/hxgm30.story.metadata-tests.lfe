(defmodule hxgm30.story.metadata-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defun test-path () "priv/testing")

(deftest toml->map
  (let ((data (hxgm30.story.metadata:read (test-path) "metadata.toml")))
    (is-equal "f08dd8c3-c1c2-32cb-802e-d5cd13a62e4f"
              (hxgm30.story.metadata:game-id data))
    (is-equal '("birch" "connihyde" "hardwood" "lichen" "rosa")
              (lists:sort (maps:keys (hxgm30.story.metadata:factions data))))
    (let ((lichen (hxgm30.story.metadata:faction data "lichen")))
      (is-equal "Hyperborea"
                (mref lichen "display-name")))))