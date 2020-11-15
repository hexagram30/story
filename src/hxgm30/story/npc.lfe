;;;; Expected format / layout of story or game directories:
;;;;
;;;; * NPCs:  BASE-DIR/GAME-NAME/src/npcs/NPC-ID.adoc
;;;;
(defmodule hxgm30.story.npc
  (export
   (npc-path-names 0)
   (npc-regex 0)
   (npc-regex-opts 0)
   (parse-npc 1)
   (read 1)))

(defun npc-path-names ()
  '(BASEDIR GAME NPCID))

(defun npc-regex ()
  (io_lib:format "(?<~s>.+)/(?<~s>.+)/src/npcs/(?<~s>.+)\.adoc"
                 (npc-path-names)))

(defun npc-regex-opts ()
  `(#(capture ,(npc-path-names) list)))

(defun parse-npc (path)
  (case (re:run path (npc-regex) (npc-regex-opts))
    (`#(match (,base-dir ,game ,npc-id)) `#m(#"base-dir" ,base-dir
                                             #"game-name" ,game
                                             #"npc-id" ,npc-id))
    (x x)))

(defun read (path)
  (maps:merge
   (parse-npc path)
   (hxgm30.story.parser:read path)))
