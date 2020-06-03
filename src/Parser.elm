module Parser exposing (parse)

import Data.AST exposing (AST)


parse : String -> Maybe AST
parse expr =
    Nothing
