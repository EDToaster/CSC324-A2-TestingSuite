#|
  Tests that the continuations of a non-atomic function is 
  generated correctly
|#
((lambda (a b c) (cps:+ a b c)) (cps:* 1 2) (cps:+ 3 5) (cps:* 1 2 3 5 1 1))