#lang racket

(define (ident->string datum) (format "\"~a\"" (symbol->string datum)))

(define (string-lst lst) (format "[~a]" (string-join (map ident->string lst) ", ")))
(define (expr-lst lst) (format "[~a]" (string-join (map transpile lst) ", ")))

(define (transpile datum)
  (match datum
    [(? integer?) (format "(IntLiteral ~a)" datum)]
    [(? boolean?) (format "(BoolLiteral ~a)" (if datum "True" "False"))]
    [(? symbol?) (format "(Identifier ~a)" (ident->string datum))]
    [(? string?) (format "(Error \"~a\")" datum)]
    [(list 'define id expr) (format "(Binding ~a ~a)" (ident->string id) (transpile expr))]
    [(list 'lambda params expr) (format "(Lambda ~a ~a)" (string-lst params) (transpile expr))]
    [(list 'if condExpr then else) (format "(If ~a ~a ~a)" (transpile condExpr) (transpile then) (transpile else))]
    [(list 'shift ident expr) (format "(Shift ~a ~a)" (ident->string ident) (transpile expr))]
    [(list 'reset expr) (format "(Reset ~a)" (transpile expr))]
    [(list 'raise error) (format "(Raise ~a)" (transpile error))]
    [(list 'try expr msg handler) (format "(Try ~a \"~a\" ~a)" (transpile expr) msg (transpile handler))]
    [(list func params ...) (format "(Call ~a ~a)" (transpile func) (expr-lst params))]
))

(define (read-to-lst to-read)
  (match (read to-read)
    [(? eof-object?) null]
    [read-datum (cons read-datum (read-to-lst to-read))])
)

(define racket-prog (vector-ref (current-command-line-arguments) 0))

(displayln 
  (match 
    (map transpile (call-with-input-string racket-prog read-to-lst))
    [(list bindings ... expr) (format "[~a] ~a" (string-join bindings ", ") expr)]))
