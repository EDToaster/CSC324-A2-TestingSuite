#|
  Testing semantic correctness of shift and reset ... 
  should have the same behaviour as racket's shift 
  and reset, but without using those identifiers!
|#
(cps:* 11 (reset (cps:* 10 (shift k (k (reset (shift k (k 10))))))))