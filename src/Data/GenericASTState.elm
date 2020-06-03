module Data.GenericASTState exposing (GenericASTState, nextState, previousState)

import Data.GenericAST exposing (GenericAST)


type alias GenericASTState =
    { current : GenericAST
    , prev : List GenericAST
    , next : List GenericAST
    }


nextState : GenericASTState -> GenericASTState
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


previousState : GenericASTState -> GenericASTState
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
