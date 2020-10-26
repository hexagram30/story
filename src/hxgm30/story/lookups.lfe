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
    ('society:governments #'hxgm30.story.lookups.society:governments/0)
    ('society:leader-types #'hxgm30.story.lookups.society:leader-types/0)
    (_ (lambda () 'undefined))))