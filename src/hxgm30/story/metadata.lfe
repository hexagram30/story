(defmodule hxgm30.story.metadata
  (export
   (faction 2)
   (factions 1)
   (game-id 1)
   (read 1) (read 2) (read 3)
   (toml->map 1) (toml->map 2)))

(defun defailt-filename () "metadata.toml")

(defun read (story-path)
  (read story-path (defailt-filename)))

(defun read (story-path filename)
  (read story-path filename '()))

(defun read (story-path filename opts)
  (let ((toml (toml:read_file
               (filename:join story-path filename)))
        (return-map? (proplists:get_value 'return opts 'false)))
    (case toml
      (`#(ok ,result) (if return-map? (toml->map result) result))
      (err err))))

;;; TOML Library Wrappers

(defun get-in (toml-dict keys)
  (case (toml:get_value (lists:droplast keys)
                        (lists:last keys)
                        toml-dict)
    (`#(,_type ,v) v)
    ('none 'undefined)
    (result result)))

;;; TOML + Map Wrappers

(defun game-id
  ((data) (when (is_map data))
   (mref data #"id"))
  ((data)
   (toml:get_value '() "id")))

(defun factions (toml-dict)
  (toml:sections '("faction" ) toml-dict))

(defun faction (toml-dict faction-name)
  (toml:sections '("faction" faction-name) toml-dict))

;;; Utility Functions

(defun toml->map (toml)
  (toml->map toml '()))

(defun toml->map (toml section-path)
  (toml:foldk section-path
              (match-lambda ((_s k `#(,_type ,v) acc)
                             (maps:merge acc `#m(,(list_to_binary k) ,v))))
              #m()
              toml))