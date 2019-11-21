#|
  Testing the transpiler by calculating the factorial of 100
  Just testing that the cpsTransformation of function calls 
  are sematically correct.
|#

(define fac-helper (lambda (n c acc)
  (if (cps:equal? n c) (cps:* acc c) (fac-helper n (cps:+ c 1) (cps:* acc c)))))
; we have to use an accumulator for fac because there is no "-" function
(define fac (lambda (n) (fac-helper n 1 1)))
(cps:equal? 
  (fac 100) 
  93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000)