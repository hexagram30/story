(defmodule hxgm30.story.metadata-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftestskip toml-data
  (let* ((test-file "priv/testing/metadata.toml")
         (data (hxgm30.story.metadata:read test-file)))
    ))