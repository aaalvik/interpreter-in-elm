module Parser.Parser exposing (parse, toGeneric)

import Data.AST exposing (AST(..))
import Data.GenericAST exposing (Children(..), GenericAST)


parse : String -> Maybe AST
parse expr =
    Nothing


toGeneric : AST -> GenericAST
toGeneric ast =
    case ast of
        Sant ->
            GenericAST "Sant" (Children [])
