module Update exposing (update)

import Data.AST as AST
import Data.GenericAST exposing (GenericAST)
import Data.GenericASTState as GenericASTState exposing (GenericASTState)
import Interpreter.Evaluator as Evaluator
import Interpreter.Parser as Parser
import List.Nonempty as Nonempty exposing (Nonempty)
import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetExprStr str ->
            ( { model | exprStr = str }
            , Cmd.none
            )

        ParseAndEvaluateStr ->
            let
                asts =
                    model.exprStr
                        |> Parser.parse
                        |> Maybe.map Evaluator.evaluate
                        |> Maybe.map (Nonempty.map AST.toGeneric)
                        |> Maybe.map toGenericASTState
            in
            ( { model
                | asts = asts
                , parseButtonClicked = True
              }
            , Cmd.none
            )

        NextState ->
            ( { model | asts = Maybe.map GenericASTState.nextState model.asts }, Cmd.none )

        PreviousState ->
            ( { model | asts = Maybe.map GenericASTState.previousState model.asts }, Cmd.none )

        KeyDown key ->
            if key == 13 then
                let
                    asts =
                        model.exprStr
                            |> Parser.parse
                            |> Maybe.map Evaluator.evaluate
                            |> Maybe.map (Nonempty.map AST.toGeneric)
                            |> Maybe.map toGenericASTState
                in
                ( { model
                    | asts = asts
                    , parseButtonClicked = True
                  }
                , Cmd.none
                )

            else
                ( model, Cmd.none )


toGenericASTState : Nonempty GenericAST -> GenericASTState
toGenericASTState asts =
    let
        first =
            Nonempty.head asts

        rest =
            Nonempty.tail asts
    in
    GenericASTState first [] rest
