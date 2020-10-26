(defmodule hxgm30.story.lookups.society
  (export
   (governments 0)
   (leader-types 0)))

(defun governments ()
 '([0 (/ 8 100.0)] autocracy
   [(/ 8 100.0) (/ 13 100.0)] bureaucracy
   [(/ 13 100.0) (/ 19 100.0)] confederacy
   [(/ 19 100.0) (/ 22 100.0)] democracy
   [(/ 22 100.0) (/ 27 100.0)] dictatorship
   [(/ 27 100.0) (/ 42 100.0)] feudalism
   [(/ 42 100.0) (/ 44 100.0)] gerontocracy
   [(/ 44 100.0) (/ 53 100.0)] hierarchy
   [(/ 53 100.0) (/ 56 100.0)] magocracy
   [(/ 56 100.0) (/ 58 100.0)] matriarchy
   [(/ 58 100.0) (/ 64 100.0)] militocracy
   [(/ 64 100.0) (/ 74 100.0)] monarchy
   [(/ 74 100.0) (/ 78 100.0)] oligarchy
   [(/ 78 100.0) (/ 80 100.0)] patriarchy
   [(/ 80 100.0) (/ 83 100.0)] meritocracy
   [(/ 83 100.0) (/ 85 100.0)] plutocracy
   [(/ 85 100.0) (/ 92 100.0)] republic
   [(/ 92 100.0) (/ 94 100.0)] satrapy
   [(/ 94 100.0) (/ 95 100.0)] kleptocracy
   [(/ 95 100.0) 1.0] theocracy))

(defun leader-types ()
 '([0 (/ 1 6.0)] political
   [(/ 1 6.0) (/ 2 6.0)] religious
   [(/ 2 6.0) (/ 3 6.0)] military
   [(/ 3 6.0) (/ 3.5 6.0)] crime
   [(/ 3.5 6.0) (/ 4 6.0)] underworld
   [(/ 4 6.0) (/ 4.5 6.0)] art
   [(/ 4.5 6.0) (/ 5 6.0)] culture
   [(/ 5 6.0) (/ 5.33 6.0)] philosophy
   [(/ 5.33 6.0) (/ 5.67 6.0)] learning
   [(/ 5.67 6.0) 1.0] magic))