import Language.Haskell.Interpreter

main :: IO ()
main = do
  runInterpreter $ setImports ["Prelude"] >> eval "3 + 5"