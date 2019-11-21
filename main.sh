#! /bin/bash

rm -rf ./tmp
mkdir ./tmp

for file in `ls ./tests`; do

  PROGRAM=`tr -cd "[:print:]\n" < "./tests/$file"`
  HASKELL=`racket transpiler.rkt "$PROGRAM"`

  echo "#!/usr/bin/racket" > ./tmp/original.rkt
  echo "#lang racket" >> ./tmp/original.rkt

  cat ./tmp/original.rkt > ./tmp/transformed.rkt

  echo "(require racket/control)" >> ./tmp/original.rkt
  echo "(define (cps:+ . args) (apply + args))" >> ./tmp/original.rkt
  echo "(define (cps:* . args) (apply * args))" >> ./tmp/original.rkt
  echo "(define (cps:equal? . args) (apply equal? args))" >> ./tmp/original.rkt
  echo "(define (is-exception-of? msg) (lambda (error) (equal? msg error)))" >> ./tmp/original.rkt
  echo "(define-syntax try
        (syntax-rules ()
          ((_ expr msg handler)
          (with-handlers ([(is-exception-of? msg) (lambda (err) (handler))]) expr))))" >> ./tmp/original.rkt

  echo "$PROGRAM" >> ./tmp/original.rkt

  echo "import Control.Monad
        import System.IO
        (forM_ [stdout, stderr] . flip hPutStrLn) $ show $ cpsTransformProgS $ (Prog $HASKELL)" | ghci -i.. Chups 2>> "./tmp/transformed.rkt" 1>/dev/null

  ORIG_RESULT=`racket ./tmp/original.rkt`
  TRANSFORMED_RESULT=`racket ./tmp/transformed.rkt`

  if [ "$ORIG_RESULT" == "$TRANSFORMED_RESULT" ]; then
    echo "+++ Passed: $file"
  else
    echo "+++ Failed: $file"
  fi
done