; Simple try catch, should return 42
(try (raise "err") "err" (lambda () 42))