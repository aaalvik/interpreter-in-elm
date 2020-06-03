module Data.ASTState exposing (ASTState, nextState, previousState)

import Data.AST exposing (AST)


type alias ASTState =
    { current : AST
    , prev : List AST
    , next : List AST
    }


nextState : ASTState -> ASTState
nextState asts =
    case asts.next of
        ast :: rest ->
            let
                newASTS =
                    { asts
                        | current = ast
                        , next = rest
                        , prev = asts.current :: asts.prev
                    }
            in
            newASTS

        [] ->
            asts


previousState : ASTState -> ASTState
previousState asts =
    case asts.prev of
        ast :: rest ->
            let
                newASTS =
                    { asts
                        | current = ast
                        , prev = rest
                        , next = asts.current :: asts.next
                    }
            in
            newASTS

        [] ->
            asts
