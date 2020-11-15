;;;; Expected format / layout of story or game directories:
;;;;
;;;; * Areas: BASE-DIR/GAME-NAME/src/areas/REGION-NAME/ZONE-NAME/AREA-ID.adoc
;;;; * NPCs:  BASE-DIR/GAME-NAME/src/npcs/NPC-ID.adoc
;;;;
(defmodule hxgm30.story
  (export
   (all-files 1)
   (area-ids 4)
   (games 1)
   (npc-ids 2)
   (regions 2)
   (zones 3)))

(defun all-files (story-path)
  (filelib:wildcard (filename:join story-path "/**/*.a*doc")))

(defun games (story-path)
  (lists:map #'filename:basename/1 (filelib:wildcard
                                    (filename:join story-path "*"))))

(defun regions (story-path game)
  (lists:map #'filename:basename/1 (filelib:wildcard
                                    (filename:join `(,story-path
                                                     ,game
                                                     "src"
                                                     "areas"
                                                     "*")))))

(defun zones (story-path game region)
  (lists:map #'filename:basename/1 (filelib:wildcard
                                    (filename:join `(,story-path
                                                     ,game
                                                     "src"
                                                     "areas"
                                                     ,region
                                                     "*")))))

(defun area-ids (story-path game region zone)
  (lists:map (clj:comp #'filename:rootname/1 #'filename:basename/1)
             (filelib:wildcard
              (filename:join `(,story-path
                               ,game
                               "src"
                               "areas"
                               ,region
                               ,zone
                               "*.a*doc")))))

(defun npc-ids (story-path game)
  (lists:map (clj:comp #'filename:rootname/1 #'filename:basename/1)
             (filelib:wildcard
              (filename:join `(,story-path
                               ,game
                               "src"
                               "npcs"
                               "*")))))
