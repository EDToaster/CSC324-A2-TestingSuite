#|
  Custom list data structures using many pairs ... 
  calculate custom foldl function
|#
(define first (lambda (p) (p #t)))
(define rest (lambda (p) (p #f)))
(define cons (lambda (a b) (lambda (i) (if i a b))))
(define foldl (lambda (proc init lst) (if (cps:equal? null lst) init (foldl proc (proc (first lst) init) (rest lst)))))
(define map (lambda (proc lst) (if (cps:equal? null lst) null (cons (proc (first lst)) (map proc (rest lst))))))
(define list-1-10 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 (cons 7 (cons 8 (cons 9 (cons 10 null)))))))))))
(define add-1 (lambda (n) (cps:+ 1 n)))
(foldl cps:+ 0 (map add-1 list-1-10))