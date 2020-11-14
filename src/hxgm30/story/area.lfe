;;;; Expected format / layout of story or game directories:
;;;;
;;;; * Areas: BASE-DIR/GAME-NAME/src/areas/REGION-NAME/ZONE-NAME/AREA-ID.adoc
;;;;
(defmodule hxgm30.story.area)

(defun area-path-names ()
  '(BASEDIR GAME REGION ZONE AREAID))

(defun area-regex ()
  (io_lib:format "(?<~s>.+)/(?<~s>.+)/src/areas/(?<~s>.+)/(?<~s>.+)/(?<~s>.+)\.adoc"
                 (area-path-names)))

(defun area-regex-opts ()
  `(#(capture ,(area-path-names) list)))

(defun parse-area (path)
  (case (re:run path (area-regex) (area-regex-opts))
    (`#(match (,base-dir ,game ,region ,zone ,area-id)) `#m(base-dir ,base-dir
                                                            game-name ,game
                                                            region ,region
                                                            zone ,zone
                                                            area-id ,area-id))
    (x x)))

(defun read (game region zone area)
  "")