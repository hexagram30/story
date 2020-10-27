(defmodule hxgm30.story.lookups
  (export
   (find 2) (find 3)
   (get 2)
   (lookup-func 1)
   (roll 1) (roll 2)))

(defun find
  ((roll dice iter) (when (>= roll dice))
   (find 1 iter))
  ((roll _ iter) (when (=< roll 0))
   (find 0 iter))
  ((roll dice iter)
   (find (/ roll dice) iter)))

(defun find
  ((roll `#((,low ,high) ,item ,iter)) (when (and (=< low roll) (=< roll high)))
   item)
  ((roll `#(,_ ,_ ,iter))
   (find roll (gb_trees:next iter))))

(defun get (id cmd)
  (let* ((func (lookup-func id))
         (`(#(dice ,dice) #(data ,data)) (funcall func)))
    (case cmd
      ('dice (io_lib:format "d~B" `(,dice)))
      ('data data)
      (_ (let* ((tree (gb_trees:from_orddict data))
                (iter (gb_trees:iterator tree))
                (init (gb_trees:next iter)))
           (case cmd
             ('tree tree)
             ('iter iter)
             ('init init)
             ('roll (find (rand:uniform) init))
             (_ (find cmd dice init))))))))

(defun roll (id)
  (get id 'roll))

(defun roll (id int)
  (get id int))

(defun lookup-func (id)
  (case id
    ;; events
    ('events:cataclysm #'hxgm30.story.lookups.events:cataclysms/0)
    ('events:disaster #'hxgm30.story.lookups.events:disasters/0)
    ('events:discovery #'hxgm30.story.lookups.events:discoveries/0)
    ('events:extinction #'hxgm30.story.lookups.events:extinctions/0)
    ('events:invasion #'hxgm30.story.lookups.events:invasions/0)
    ('events:new-organization #'hxgm30.story.lookups.events:new-organizations/0)
    ('events:world-shaking #'hxgm30.story.lookups.events:world-shaking/0)
    ;; society
    ('society:government #'hxgm30.story.lookups.society:governments/0)
    ('society:leader-type #'hxgm30.story.lookups.society:leader-types/0)
    (_ (lambda () 'undefined))))