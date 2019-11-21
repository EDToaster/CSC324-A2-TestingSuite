#! /bin/bash

rm -rf ./tmp
mkdir ./tmp

FILES=`ls ./tests`

LENGTH=`echo $FILES | wc -w`
PASSED="0"
FAILED="0"

ORIG_HEADER=`cat ./origTransformHeader.rkt`

echo "Running $LENGTH tests ..."

for file in $FILES; do
  PROGRAM=`tr -cd "[:print:]\n" < "./tests/$file"`
  ORIG="./tmp/$file.o.rkt"
  TRAN="./tmp/$file.t.rkt"

  # headers for the language
  echo "#!/usr/bin/racket" > "$ORIG"
  echo "#lang racket" >> "$ORIG"

  # both files need this header
  cat "$ORIG" > "$TRAN"

  # original racket header and program -- needed for evaulation of the original program input
  printf "$ORIG_HEADER\n$PROGRAM" >> "$ORIG"

  # transpile to haskell syntax
  HASKELL=`racket transpiler.rkt "$PROGRAM"`
  # evaulate the haskell version in ghci, to get cpsTransformed racket
  echo "import Control.Monad
        import System.IO
        (forM_ [stdout, stderr] . flip hPutStrLn) $ show $ cpsTransformProgS $ (Prog $HASKELL)" | ghci -i.. Chups 2>> "$TRAN" 1>/dev/null

  ORIG_RESULT=`racket "$ORIG"`
  TRANSFORMED_RESULT=`racket "$TRAN"`

  if [ "$ORIG_RESULT" == "$TRANSFORMED_RESULT" ]; then
    echo "+++ Passed: $file"
    ((PASSED++))
  else
    echo "+++ Failed: $file"
    ((FAILED++))
  fi
done

echo "Passed $PASSED out of $LENGTH tests"
if [ "$FAILED" != "0" ]; then
  echo "($FAILED tests failed)"
fi