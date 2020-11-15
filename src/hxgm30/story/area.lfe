;;;; Expected format / layout of story or game directories:
;;;;
;;;; * Areas: BASE-DIR/GAME-NAME/src/areas/REGION-NAME/ZONE-NAME/AREA-ID.adoc
;;;;
(defmodule hxgm30.story.area
  (export
   (area-path-names 0)
   (area-regex 0)
   (area-regex-opts 0)
   (parse-area 1)
   (read 1)))

(defun area-path-names ()
  '(BASEDIR GAME REGION ZONE AREAID))

(defun area-regex ()
  (io_lib:format "(?<~s>.+)/(?<~s>.+)/src/areas/(?<~s>.+)/(?<~s>.+)/(?<~s>.+)\.adoc"
                 (area-path-names)))

(defun area-regex-opts ()
  `(#(capture ,(area-path-names) list)))

(defun parse-area (path)
  (case (re:run path (area-regex) (area-regex-opts))
    (`#(match (,base-dir ,game ,region ,zone ,area-id)) `#m(#"base-dir" ,base-dir
                                                            #"game-name" ,game
                                                            #"region" ,region
                                                            #"zone" ,zone
                                                            #"area-id" ,area-id))
    (x x)))

(defun read (path)
  (maps:merge
   (parse-area path)
   (hxgm30.story.parser:read path)))
