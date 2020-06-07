module Data.AST exposing (AST(..), toGeneric)

import Data.GenericAST exposing (Children(..), GenericAST)


type AST
    = Sant
    | Usant
    | Ikke AST
    | Og AST AST
    | Eller AST AST


toGeneric : AST -> GenericAST
toGeneric ast =
    case ast of
        Sant ->
            GenericAST "Sant" (Children [])

        Usant ->
            GenericAST "Usant" (Children [])

        Ikke ast_ ->
            GenericAST "Ikke" (Children <| [ toGeneric ast_ ])

        Og ast1 ast2 ->
            GenericAST "Og" (Children <| [ toGeneric ast1, toGeneric ast2 ])

        Eller ast1 ast2 ->
            GenericAST "Eller" (Children <| [ toGeneric ast1, toGeneric ast2 ])
