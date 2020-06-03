module Update exposing (update)

import Data.AST as AST
import Data.GenericAST exposing (GenericAST)
import Data.GenericASTState as GenericASTState exposing (GenericASTState)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Parser.Parser as Parser


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetExprStr str ->
            ( { model | exprStr = str }
            , Cmd.none
            )

        ParseStr ->
            let
                -- TODO: Put regular parse tree in model
                parseResult =
                    Parser.parse model.exprStr

                genericParseResult =
                    Result.map AST.toGeneric parseResult
            in
            ( { model
                | asts =
                    genericParseResult
                        |> Result.toMaybe
                        |> Maybe.map (\ast -> GenericASTState ast [] [])
              }
            , Cmd.none
            )

        NextState ->
            ( { model | asts = Maybe.map GenericASTState.nextState model.asts }, Cmd.none )

        PreviousState ->
            ( { model | asts = Maybe.map GenericASTState.previousState model.asts }, Cmd.none )

        KeyDown key ->
            if key == 13 then
                ( { model
                    | asts =
                        model.exprStr
                            |> Parser.parse
                            |> Result.toMaybe
                            |> Maybe.map AST.toGeneric
                            |> Maybe.map (\ast -> GenericASTState ast [] [])
                  }
                , Cmd.none
                )

            else
                ( model, Cmd.none )


resetInput : Model -> Model
resetInput model =
    { model | exprStr = "", asts = Nothing }


setASTS : Maybe GenericASTState -> Model -> Model
setASTS newASTs model =
    { model | asts = newASTs }


updateASTS : GenericAST -> List GenericAST -> Model -> Model
updateASTS ast next model =
    let
        newASTS =
            { current = ast
            , next = next
            , prev = []
            }
    in
    { model | asts = Just newASTS }
