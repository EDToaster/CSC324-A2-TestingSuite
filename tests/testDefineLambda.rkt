#| 
  Test assigning lambdas to functions, mainly testing that lambda
  transformations are correct.
|#
(define f (lambda (a b) (cps:+ a b)))

#| 
  Testing that values can be assigned to identifiers,
  and that the values are passed through the identity continuation 
|#
(define x 1)
(define y 2)
(f x y)