#|
    Nested lambdas, again checking the continuations
|#
((lambda (x) (
    (lambda (y) (cps:+ y x)) 12)) 13)