#|
  Using structs!
  Defines points where:
    0: x coord
    1: y coord
    2: returns the square euclidean distance from (0,0)
|#
(define Point (lambda (x y) (lambda (msg) (
  if (cps:equal? msg 0) x (
    if (cps:equal? msg 1) y (
      if (cps:equal? msg 2) (cps:+ (cps:* x x) (cps:* y y)) 3
    ))))))

(define p1 (Point 2 2))
(p1 2)