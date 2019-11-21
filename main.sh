#! /bin/bash

rm -rf ./tmp
mkdir ./tmp

for file in `ls ./tests`; do
  PROGRAM=`tr -cd "[:print:]\n" < "./tests/$file"`

  # headers for the language
  echo "#!/usr/bin/racket" > ./tmp/original.rkt
  echo "#lang racket" >> ./tmp/original.rkt

  # both files need this header
  cat ./tmp/original.rkt > ./tmp/transformed.rkt

  # original racket header and program -- needed for evaulation of the original program input
  echo "(require racket/control)
        (define (cps:+ . args) (apply + args))
        (define (cps:* . args) (apply * args))
        (define (cps:equal? . args) (apply equal? args))
        (define (is-exception-of? msg) (lambda (error) (equal? msg error)))
        (define-syntax try
              (syntax-rules ()
                ((_ expr msg handler)
                (with-handlers ([(is-exception-of? msg) (lambda (err) (handler))]) expr))))
        $PROGRAM" >> ./tmp/original.rkt

  # transpile to haskell syntax
  HASKELL=`racket transpiler.rkt "$PROGRAM"`
  # evaulate the haskell version in ghci, to get cpsTransformed racket
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