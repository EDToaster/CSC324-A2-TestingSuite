#|
  Try-catching errors.
|#

(define infinity 42)
(define no-zero (lambda (n) (if (cps:equal? n 0) (raise "what are you doing") n)))
(try (no-zero 0) "what are you doing" 42)