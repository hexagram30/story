;;;; Expected format / layout of story or game directories:
;;;;
;;;; * Areas: BASE-DIR/GAME-NAME/src/areas/REGION-NAME/ZONE-NAME/AREA-ID.adoc
;;;; * NPCs:  BASE-DIR/GAME-NAME/src/npcs/NPC-ID.adoc
;;;;
(defmodule hxgm30.story)

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

(defun npcs (story-path game)
  (lists:map (clj:comp #'filename:rootname/1 #'filename:basename/1)
             (filelib:wildcard
              (filename:join `(,story-path
                               ,game
                               "src"
                               "npcs"
                               "*")))))
