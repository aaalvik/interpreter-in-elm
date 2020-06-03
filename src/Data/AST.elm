module Data.AST exposing (AST(..), toGeneric)

import Data.GenericAST exposing (Children(..), GenericAST)


type AST
    = Sant
    | Usant


toGeneric : AST -> GenericAST
toGeneric ast =
    case ast of
        Sant ->
            GenericAST "Sant" (Children [])

        Usant ->
            GenericAST "Usant" (Children [])
