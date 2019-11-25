(require racket/control)
(define (cps:+ . args) (apply + args))
(define (cps:* . args) (apply * args))
(define (cps:equal? . args) (apply equal? args))
(define (is-exception-of? msg) (lambda (error) (equal? msg error)))
(define-syntax try
      (syntax-rules ()
        ((_ expr msg handler)
        (with-handlers ([(is-exception-of? msg) (lambda (err) handler)]) expr))))