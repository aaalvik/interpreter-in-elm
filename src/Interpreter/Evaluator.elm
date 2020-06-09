module Interpreter.Evaluator exposing (evaluate)

import Data.AST exposing (AST(..))
import List.Nonempty as Nonempty exposing (Nonempty)


evaluate : AST -> Nonempty AST
evaluate =
    collectSteps


collectSteps : AST -> Nonempty AST
collectSteps ast =
    if isValue ast then
        Nonempty.fromElement ast

    else
        Nonempty.cons ast (collectSteps <| takeOneStep ast)



-- Steg 1: Lag en small step evaluator


takeOneStep : AST -> AST
takeOneStep ast =
    case ast of
        Sant ->
            Sant

        Usant ->
            Usant

        Ikke Sant ->
            Usant

        Ikke Usant ->
            Sant

        Ikke ast_ ->
            Ikke <| takeOneStep ast_

        Og ast1 ast2 ->
            -- hvis ast1 ikke er ferdig, ta ett steg på den
            if not <| isValue ast1 then
                Og (takeOneStep ast1) ast2
                -- hvis ast1 er ferdig, og ast2 ikke er det

            else if not <| isValue ast2 then
                Og ast1 (takeOneStep ast2)
                -- begge to er ferdig

            else
                evalBinOp (&&) ast1 ast2

        Eller ast1 ast2 ->
            -- hvis ast1 ikke er ferdig, ta ett steg på den
            if not <| isValue ast1 then
                Eller (takeOneStep ast1) ast2
                -- hvis ast1 er ferdig, og ast2 ikke er det

            else if not <| isValue ast2 then
                Eller ast1 (takeOneStep ast2)
                -- begge to er ferdig

            else
                evalBinOp (||) ast1 ast2



-- Helpers


isValue : AST -> Bool
isValue ast =
    ast == Sant || ast == Usant


evalBinOp : (Bool -> Bool -> Bool) -> AST -> AST -> AST
evalBinOp operator val1 val2 =
    if operator (val1 == Sant) (val2 == Sant) then
        Sant

    else
        Usant
