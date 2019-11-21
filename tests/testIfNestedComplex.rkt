#|
  Basic branching logic.
|#
(define f (lambda (a) a))
(if 
  (f #t) 
  (if (f #f) (f 1) (f 2))
  (if (f #f) (f 3) (f 4)))