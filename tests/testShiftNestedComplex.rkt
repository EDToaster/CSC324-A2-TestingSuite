#|
  Testing shift/reset semantics when k is nested
|#
(reset (cps:* 10 (shift k1 (k1 (k1 (reset (cps:+ 19 (shift _k (_k (_k (k1 10)))))))))))