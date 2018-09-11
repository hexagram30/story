(ns hxgm30.story.components.story
  (:require
   [com.stuartsierra.component :as component]
   [hxgm30.common.util :as util]
   [hxgm30.dice.components.random :as random]
   [hxgm30.story.config :as config]
   [hxgm30.story.lookups :as lookups]
   [taoensso.timbre :as log]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Utility Functions   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TBD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Story Component API   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Events

(defn select-government
  [system]
  (util/percent-> (random/float system) lookups/governments))

(defn select-leader-type
  [system]
  (util/percent-> (random/float system) lookups/leader-types))

(defn select-world-shaking-event
  [system]
  (let [event (util/percent->
               (random/float system) lookups/world-shaking-events)]
    (cond (contains? #{:cataclysm :disaster} event)
          [event (util/percent->
                  (random/float system) lookups/disasters)]

          (= :invasion event)
          [event (util/percent->
                  (random/float system) lookups/invasions)]

          (contains? #{:extinction :depletion} event)
          [event (util/percent->
                  (random/float system) lookups/extinctions)]

          (= :new-organization event)
          [event (util/percent->
                  (random/float system) lookups/new-organizations)]

          (contains? #{:discovery :expansion :invention} event)
          [event (util/percent->
                  (random/float system) lookups/discoveries)]

          :else event)))

(defn select-disaster
  [system]
  (util/percent-> (random/float system) lookups/disasters))

(defn select-cataclysm
  [system]
  (util/percent-> (random/float system) lookups/cataclysms))

(defn select-extinction
  [system]
  (util/percent-> (random/float system) lookups/extinctions))

(defn select-new-organization
  [system]
  (util/percent-> (random/float system) lookups/new-organizations))

(defn select-discovery
  [system]
  (util/percent-> (random/float system) lookups/discoveries))

;; Goals

(defn select-dungeon-goal
  [system]
  (util/percent-> (random/float system) lookups/dungeon-goals))

(defn select-wilderness-goal
  [system]
  (util/percent-> (random/float system) lookups/wilderness-goals))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Component Lifecycle Implementation   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrecord StoryManager [])

(defn start
  [this]
  (log/info "Starting story manager component ...")
  (log/debug "Started story manager component.")
  this)

(defn stop
  [this]
  (log/info "Stopping story manager component ...")
  (log/debug "Stopped story manager component.")
  this)

(def lifecycle-behaviour
  {:start start
   :stop stop})

(extend StoryManager
  component/Lifecycle
  lifecycle-behaviour)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Component Constructor   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn create-component
  ""
  []
  (map->StoryManager {}))
