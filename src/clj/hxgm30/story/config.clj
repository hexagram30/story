(ns hxgm30.story.config
  (:require
   [hxgm30.common.file :as common]))

(def config-file "hexagram30-config/story.edn")

(defn data
  ([]
    (data config-file))
  ([filename]
    (common/read-edn-resource filename)))
