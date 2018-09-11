
(def governments
 {[0 (/ 8 100.0)] :autocracy
  [(/ 8 100.0) (/ 13 100.0)] :bureaucracy
  [(/ 13 100.0) (/ 19 100.0)] :confederacy
  [(/ 19 100.0) (/ 22 100.0)] :democracy
  [(/ 22 100.0) (/ 27 100.0)] :dictatorship
  [(/ 27 100.0) (/ 42 100.0)] :feudalism
  [(/ 42 100.0) (/ 44 100.0)] :gerontocracy
  [(/ 44 100.0) (/ 53 100.0)] :hierarchy
  [(/ 53 100.0) (/ 56 100.0)] :magocracy
  [(/ 56 100.0) (/ 58 100.0)] :matriarchy
  [(/ 58 100.0) (/ 64 100.0)] :militocracy
  [(/ 64 100.0) (/ 74 100.0)] :monarchy
  [(/ 74 100.0) (/ 78 100.0)] :oligarchy
  [(/ 78 100.0) (/ 80 100.0)] :patriarchy
  [(/ 80 100.0) (/ 83 100.0)] :meritocracy
  [(/ 83 100.0) (/ 85 100.0)] :plutocracy
  [(/ 85 100.0) (/ 92 100.0)] :republic
  [(/ 92 100.0) (/ 94 100.0)] :satrapy
  [(/ 94 100.0) (/ 95 100.0)] :kleptocracy
  [(/ 95 100.0) 1.0] :theocracy})

(def leader-types
 {[0 (/ 1 6.0)] :political
  [(/ 1 6.0) (/ 2 6.0)] :religious
  [(/ 2 6.0) (/ 3 6.0)] :military
  [(/ 3 6.0) (/ 3.5 6.0)] :crime
  [(/ 3.5 6.0) (/ 4 6.0)] :underworld
  [(/ 4 6.0) (/ 4.5 6.0)] :art
  [(/ 4.5 6.0) (/ 5 6.0)] :culture
  [(/ 5 6.0) (/ 5.33 6.0)] :philosophy
  [(/ 5.33 6.0) (/ 5.67 6.0)] :learning
  [(/ 5.67 6.0) 1.0] :magic})

(def world-shaking-events
 {[0 (/ 5 100.0)] :rise-of-leader
  [(/ 5 100.0) (/ 10 100.0)] :rise-of-era
  [(/ 10 100.0) (/ 15 100.0)] :fall-of-leader
  [(/ 15 100.0) (/ 20 100.0)] :fall-of-era
  [(/ 20 100.0) (/ 25 100.0)] :cataclysm
  [(/ 25 100.0) (/ 30 100.0)] :disaster
  [(/ 30 100.0) (/ 35 100.0)] :assault
  [(/ 35 100.0) (/ 40 100.0)] :invasion
  [(/ 40 100.0) (/ 43.33 100.0)] :rebellion
  [(/ 43.33 100.0) (/ 46.67 100.0)] :revolution
  [(/ 46.67 100.0) (/ 50 100.0)] :overthrow
  [(/ 50 100.0) (/ 55 100.0)] :extinction
  [(/ 55 100.0) (/ 60 100.0)] :depletion
  [(/ 60 100.0) (/ 70 100.0)] :new-organization
  [(/ 70 100.0) (/ 73.33 100.0)] :discovery
  [(/ 73.33 100.0) (/ 76.67 100.0)] :expansion
  [(/ 76.67 100.0) (/ 80 100.0)] :invention
  [(/ 80 100.0) (/ 83.33 100.0)] :prediction
  [(/ 83.33 100.0) (/ 86.67 100.0)] :omen
  [(/ 86.67 100.0) (/ 90 100.0)] :prophecy
  [(/ 90 100.0) (/ 95 100.0)] :myth
  [(/ 95 100.0) 1.0] :legend})

(def disasters ; regional
 {[0 (/ 10 100.0)] :earth-quake
  [(/ 10 100.0) (/ 15 100.0)] :famine
  [(/ 15 100.0) (/ 20 100.0)] :drought
  [(/ 20 100.0) (/ 30 100.0)] :fire
  [(/ 30 100.0) (/ 40 100.0)] :flood
  [(/ 40 100.0) (/ 45 100.0)] :plague
  [(/ 45 100.0) (/ 50 100.0)] :disease
  [(/ 50 100.0) (/ 60 100.0)] :meteor
  [(/ 60 100.0) (/ 63.33 100.0)] :hurricane
  [(/ 63.33 100.0) (/ 66.67 100.0)] :tornado
  [(/ 66.67 100.0) (/ 70 100.0)] :tsunami
  [(/ 70 100.0) (/ 80 100.0)] :volcano
  [(/ 80 100.0) (/ 85 100.0)] :user-magic ; bad or gone awry
  [(/ 85 100.0) (/ 90 100.0)] :planar-magic
  [(/ 90 100.0) 1.0] :divine-judgement})

(def cataclysms ;global
  disasters)

(def invasions
  {[0 (/ 1 8.0)] :criminal-enterprise
   [(/ 1 8.0) (/ 1.5 8.0)] :monsters
   [(/ 1.5 8.0) (/ 2 8.0)] :unique-monster
   [(/ 2 8.0) (/ 3 8.0)] :planar-threat
   [(/ 3 8.0) (/ 3.33 8.0)] :adversary-reawakened
   [(/ 3.33 8.0) (/ 3.67 8.0)] :adversary-reborn
   [(/ 3.67 8.0) (/ 4 8.0)] :adversary-resurgent
   [(/ 4 8.0) (/ 5 8.0)] :splinter-faction
   [(/ 5 8.0) (/ 6 8.0)] :savage-tribe
   [(/ 6 8.0) (/ 7 8.0)] :secret-society
   [(/ 7 8.0) (/ 8 8.0)] :traitorous-ally})

(def extinctions
 {[0 (/ 0.2 8.0)] :animal
  [(/ 0.2 8.0) (/ 0.4 8.0)] :insect
  [(/ 0.4 8.0) (/ 0.6 8.0)] :bird
  [(/ 0.6 8.0) (/ 0.8 8.0)] :fish
  [(/ 0.8 8.0) (/ 1.0 8.0)] :livestock
  [(/ 1.0 8.0) (/ 2.0 8.0)] :habitable-land
  [(/ 2.0 8.0) (/ 2.2 8.0)] :magic
  [(/ 2.2 8.0) (/ 2.4 8.0)] :magic-users
  [(/ 2.4 8.0) (/ 2.6 8.0)] :all-magic
  [(/ 2.6 8.0) (/ 2.8 8.0)] :kind-of-magic
  [(/ 2.8 8.0) (/ 3.0 8.0)] :school-of-magic
  [(/ 3.0 8.0) (/ 3.33 8.0)] :gems
  [(/ 3.33 8.0) (/ 3.67 8.0)] :metals
  [(/ 3.67 8.0) (/ 4.0 8.0)] :ores
  [(/ 4.0 8.0) (/ 4.25 8.0)] :monster
  [(/ 4.25 8.0) (/ 4.5 8.0)] :unicorn
  [(/ 4.5 8.0) (/ 4.75 8.0)] :manticore
  [(/ 4.75 8.0) (/ 5.0 8.0)] :dragon
  [(/ 5.0 8.0) (/ 5.2 8.0)] :people
  [(/ 5.2 8.0) (/ 5.4 8.0)] :family-line
  [(/ 5.4 8.0) (/ 5.6 8.0)] :clan
  [(/ 5.6 8.0) (/ 5.8 8.0)] :culture
  [(/ 5.8 8.0) (/ 6.0 8.0)] :race
  [(/ 6.0 8.0) (/ 6.2 8.0)] :plant
  [(/ 6.2 8.0) (/ 6.4 8.0)] :crop
  [(/ 6.4 8.0) (/ 6.6 8.0)] :tree
  [(/ 6.6 8.0) (/ 6.8 8.0)] :herb
  [(/ 6.8 8.0) (/ 7.0 8.0)] :forest
  [(/ 7.0 8.0) (/ 7.25 8.0)] :waterway
  [(/ 7.25 8.0) (/ 7.5 8.0)] :river
  [(/ 7.5 8.0) (/ 7.75 8.0)] :lake
  [(/ 7.75 8.0) (/ 8.0 8.0)] :ocean})

(def new-organizations
 {[0 (/ 5 100.0)] :crime-syndicate
  [(/ 5 100.0) (/ 10 100.0)] :bandit-confederacy
  [(/ 10 100.0) (/ 14 100.0)] :guild
  [(/ 14 100.0) (/ 16 100.0)] :masons
  [(/ 16 100.0) (/ 18 100.0)] :apothecaries
  [(/ 18 100.0) (/ 20 100.0)] :goldsmiths
  [(/ 20 100.0) (/ 25 100.0)] :magical-circle
  [(/ 25 100.0) (/ 30 100.0)] :magical-society
  [(/ 30 100.0) (/ 35 100.0)] :military-order
  [(/ 35 100.0) (/ 40 100.0)] :knightly-order
  [(/ 40 100.0) (/ 43.3 100.0)] :family-dynasty
  [(/ 43.3 100.0) (/ 46.7 100.0)] :tribe
  [(/ 46.7 100.0) (/ 50 100.0)] :clan
  [(/ 50 100.0) (/ 53.3 100.0)] :philosophy
  [(/ 53.3 100.0) (/ 56.7 100.0)] :discipline
  [(/ 56.7 100.0) (/ 60 100.0)] :ideaology
  [(/ 60 100.0) (/ 62 100.0)] :realm
  [(/ 62 100.0) (/ 64 100.0)] :village
  [(/ 64 100.0) (/ 66 100.0)] :town
  [(/ 66 100.0) (/ 68 100.0)] :duchy
  [(/ 68 100.0) (/ 70 100.0)] :kingdom
  [(/ 70 100.0) (/ 73.3 100.0)] :religion
  [(/ 73.3 100.0) (/ 76.7 100.0)] :sect
  [(/ 76.7 100.0) (/ 80 100.0)] :denomination
  [(/ 80 100.0) (/ 85 100.0)] :school
  [(/ 85 100.0) (/ 90 100.0)] :university
  [(/ 90 100.0) (/ 93.3 100.0)] :secret-society
  [(/ 93.3 100.0) (/ 96.7 100.0)] :cult
  [(/ 96.7 100.0) 1.0] :cabal})

(def discoveries
 {[0 (/ 5 100.0)] :ancient-city
  [(/ 5 100.0) (/ 10 100.0)] :lost-legendary-city
  [(/ 10 100.0) (/ 13.3 100.0)] :animal
  [(/ 13.3 100.0) (/ 16.7 100.0)] :monster
  [(/ 16.7 100.0) (/ 20 100.0)] :magical-mutation
  [(/ 20 100.0) (/ 21.67 100.0)] :helpful-invention
  [(/ 21.67 100.0) (/ 23.3 100.0)] :helpful-technology
  [(/ 23.3 100.0) (/ 25 100.0)] :helpful-magic
  [(/ 25 100.0) (/ 26.33 100.0)] :destructive-invention
  [(/ 26.33 100.0) (/ 27.67 100.0)] :destructive-technology
  [(/ 27.67 100.0) (/ 30 100.0)] :destructive-magic
  [(/ 30 100.0) (/ 32.5 100.0)] :new-god
  [(/ 32.5 100.0) (/ 35 100.0)] :new-planar-entity
  [(/ 35 100.0) (/ 37.5 100.0)] :forgotten-god
  [(/ 37.5 100.0) (/ 40 100.0)] :forgotten-planar-entity
  [(/ 40 100.0) (/ 42.5 100.0)] :new-artifact
  [(/ 42.5 100.0) (/ 45 100.0)] :new-religious-relic
  [(/ 45 100.0) (/ 47.5 100.0)] :rediscovered-artifact
  [(/ 47.5 100.0) (/ 50 100.0)] :rediscovered-religious-relic
  [(/ 50 100.0) (/ 52.5 100.0)] :new-island
  [(/ 52.5 100.0) (/ 55 100.0)] :new-continent
  [(/ 55 100.0) (/ 57.5 100.0)] :lost-world
  [(/ 57.5 100.0) (/ 60 100.0)] :demiplane
  [(/ 60 100.0) (/ 63.3 100.0)] :otherworldly-object
  [(/ 63.3 100.0) (/ 66.7 100.0)] :planar-portal
  [(/ 66.7 100.0) (/ 70 100.0)] :alien-craft
  [(/ 70 100.0) (/ 72 100.0)] :people
  [(/ 72 100.0) (/ 74 100.0)] :race
  [(/ 74 100.0) (/ 76 100.0)] :tribe
  [(/ 76 100.0) (/ 78 100.0)] :lost-civilization
  [(/ 78 100.0) (/ 80 100.0)] :colony
  [(/ 80 100.0) (/ 84 100.0)] :plant
  [(/ 84 100.0) (/ 86 100.0)] :miracle-herb
  [(/ 86 100.0) (/ 88 100.0)] :fungal-parasite
  [(/ 88 100.0) (/ 90 100.0)] :sentient-plant
  [(/ 90 100.0) (/ 92 100.0)] :resource
  [(/ 92 100.0) (/ 94 100.0)] :wealth
  [(/ 94 100.0) (/ 96 100.0)] :gold
  [(/ 96 100.0) (/ 98 100.0)] :gems
  [(/ 98 100.0) 1.0] :mithril})
