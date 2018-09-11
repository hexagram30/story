(ns hxgm30.story.core
  "This namespace is system-based; before making any function calls, a
  system that includes a `:random` component needs to be started."
  (:require
    [clojusc.system-manager.core :as system-manager]
    [clojusc.twig :as logger]
    [hxgm30.story.components.core]
    [taoensso.timbre :as log])
  (:gen-class))

(defn -main
  [& args]
  (logger/set-level! '[hxgm30] :error)
  (system-manager/setup-manager {:init 'hxgm30.story.components.core/cli})
  (system-manager/startup)
  (log/debug "CLI currently unsupported.")
  (system-manager/shutdown))
