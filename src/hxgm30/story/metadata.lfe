;;;; The module is responsible for extracing game metadata from TOML files.
(defmodule hxgm30.story.metadata
  (export
   ;; Story API
   (faction 2)
   (factions 1)
   (game-id 1)
   (read 1) (read 2)))

(defun default-filename () "metadata.toml")

(defun read (story-path)
  (read story-path (default-filename)))

(defun read (story-path filename)
  (bombadil:read (filename:join story-path filename)))

(defun game-id (data)
  (mref data "id"))

(defun factions (data)
  (mref data "faction"))

(defun faction (data faction-name)
  (clj:get-in data `("faction" ,faction-name)))
