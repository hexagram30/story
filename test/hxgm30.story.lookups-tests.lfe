(defmodule hxgm30.story.lookups-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest get-dice
  (is-equal "d100"
            (hxgm30.story.lookups:get 'events:discovery 'dice))
  (is-equal "d20"
            (hxgm30.story.lookups:get 'goals:dungeon 'dice))
  (is-equal "d12"
            (hxgm30.story.lookups:get 'goals:wilderness 'dice))
  (is-equal "d6"
            (hxgm30.story.lookups:get 'society:leader-type 'dice)))
    
(deftest roll-goals-dungeon
   (is-equal "Stop the dungeon's monstrous inhabitants from raiding the surface world."
             (hxgm30.story.lookups:roll 'goals:dungeon -1))
   (is-equal "Stop the dungeon's monstrous inhabitants from raiding the surface world."
             (hxgm30.story.lookups:roll 'goals:dungeon 0))
   (is-equal "Stop the dungeon's monstrous inhabitants from raiding the surface world."
             (hxgm30.story.lookups:roll 'goals:dungeon 1))
   (is-equal "Acquire treasure."
             (hxgm30.story.lookups:roll 'goals:dungeon 4))
   (is-equal "Find passage to a secret or hidden location by traversing through the dungeon."
             (hxgm30.story.lookups:roll 'goals:dungeon 20))
   (is-equal "Find passage to a secret or hidden location by traversing through the dungeon."
             (hxgm30.story.lookups:roll 'goals:dungeon 21)))

(deftest roll-events-discovery
  (is-equal 'ancient-city
            (hxgm30.story.lookups:roll 'events:discovery 1))
  (is-equal 'new-artifact
            (hxgm30.story.lookups:roll 'events:discovery 42))
  (is-equal 'mithril
            (hxgm30.story.lookups:roll 'events:discovery 100)))

(deftest roll-society-leader-type
  (is-equal 'political
            (hxgm30.story.lookups:roll 'society:leader-type 1))
  (is-equal 'military
            (hxgm30.story.lookups:roll 'society:leader-type 3))
  (is-equal 'magical
            (hxgm30.story.lookups:roll 'society:leader-type 6)))