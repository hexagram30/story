;;;; The module is responsible for extracing game metadata from TOML files.
;;;;
;;;; As such, it makes extensive use of the Erlang TOML library:
;;;; * https://github.com/dozzie/toml
;;;; * http://dozzie.jarowit.net/api/erlang-toml/
(defmodule hxgm30.story.metadata
  (export
   ;; TOML API
   (read 1) (read 2) (read 3)
   (section->map 2)
   (toml->map 1)
   ;; Story API
   (faction 2)
   (factions 1)
   (game-id 1)
   ;; Utility functions
   (assoc 2)
   (assoc-in 3)
   (get-in 2)
   (get-path 2)
   (get-paths 1) (get-paths 3)
   (toml-> 1)))

;;; Defaults

(defun default-filename () "metadata.toml")

;;; TOML API

(defun read (story-path)
  (read story-path (default-filename)))

(defun read (story-path filename)
  (read story-path filename '()))

(defun read (story-path filename opts)
  (let ((toml (toml:read_file
               (filename:join story-path filename)))
        (return-map? (proplists:get_value 'return opts 'false)))
    (case toml
      (`#(ok ,result) (if return-map? (toml->map result) result))
      (err err))))

(defun section->map (toml section-path)
  (toml:foldk section-path
              (lambda (_section k v acc)
                (maps:merge acc
                            `#m(,k ,(toml-> v))))
              #m()
              toml))

(defun toml->map (toml)
  (lists:foldl (match-lambda
                 (('() acc)
                  (maps:merge acc (section->map toml '())))
                 ((x acc)
                  (assoc-in acc x (section->map toml x))))
               #m()
               (get-paths toml)))


;; Story API

(defun game-id
  ((data) (when (is_map data))
   (mref data #"id"))
  ((data)
   (let ((`#(,_type ,id) (toml:get_value '() "id" data)))
     id)))

(defun factions (toml-dict)
  (toml:sections '("faction" ) toml-dict))

(defun faction (toml-dict faction-name)
  (toml:sections '("faction" faction-name) toml-dict))

;;; Utility functions

;; Map helpers

(defun assoc
  ((map '())
   map)
  ((map `((,k ,v) . ,tail))
   (assoc (maps:merge map `#m(,k ,v)) tail)))

(defun assoc-in
  ((map '() _)
   map)
  ((map `(,k . ()) v)
   (assoc map `((,k ,v))))
  ((map `(,k . ,tail) v)
   (assoc map `((,k ,(assoc-in (maps:get k map #m()) tail v))))))

;; TOML Library Wrappers

(defun get-in
  ((toml keys) (when (andalso (is_tuple toml) (== (element 1 toml) 'dict)))
   (case (toml:get_value (lists:droplast keys)
                         (lists:last keys)
                         toml)
     (`#(,_type ,v) v)
     ('none 'undefined)
     (result result)))
  ((data keys)
   (clj:get-in data keys)))

;;; Utility Functions

(defun get-path (toml path)
  (toml:folds path
              (lambda (toml s acc)
                ;;(lfe_io:format "section: ~p~n" `(,s))
                ;;(lfe_io:format "acc: ~p~n" `(,acc))
                (lists:append acc `(,s)))
              '()
              toml))

(defun get-paths (toml)
  (get-paths toml 'undefined '(())))

(defun get-paths
  ((_toml '() paths)
   paths)
  ((toml path paths)
   ;;(lfe_io:format "starting path: ~p~n" `(,path))
   ;;(lfe_io:format "starting paths: ~p~n" `(,paths))
   (let* ((path (if (is_list path) path '(())))
          (p (lists:append (lists:map (lambda (x)
                                        (get-path toml x))
                                      path)))
          (ps (++ paths p)))
     ;;(lfe_io:format "ending path: ~p~n" `(,p))
     ;;(lfe_io:format "ending paths: ~p~n" `(,ps))
     (get-paths toml p ps))))

(defun toml->
  ((`#(string ,string))
   string)
  ((`#(integer ,int))
   int)
  ((`#(float ,float))
   float)
  ((`#(boolean ,bool))
   bool)
  ((`#(datetime ,dt))
   dt)
  ((`#(array #(,_type ,list)))
   list)
  ((`#(empty ,list))
   list)
  ((`#(object #(,_type ,obj)))
   obj))