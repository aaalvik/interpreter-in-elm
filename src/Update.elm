module Update exposing (update)

import Data.AST exposing (AST)
import Data.ASTState as ASTState exposing (ASTState)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Parser
import View.Tree as Tree


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetExprStr str ->
            ( { model | exprStr = str }
            , Cmd.none
            )

        ParseStr ->
            ( { model
                | asts =
                    model.exprStr
                        |> Parser.parse
                        |> Maybe.map (\ast -> ASTState ast [] [])
              }
            , Cmd.none
            )

        NextState ->
            ( { model | asts = Maybe.map ASTState.nextState model.asts }, Cmd.none )

        PreviousState ->
            ( { model | asts = Maybe.map ASTState.previousState model.asts }, Cmd.none )

        KeyDown key ->
            if key == 13 then
                ( { model
                    | asts =
                        model.exprStr
                            |> Parser.parse
                            |> Maybe.map (\ast -> ASTState ast [] [])
                  }
                , Cmd.none
                )

            else
                ( model, Cmd.none )


resetInput : Model -> Model
resetInput model =
    { model | exprStr = "", asts = Nothing }


setASTS : Maybe ASTState -> Model -> Model
setASTS newASTs model =
    { model | asts = newASTs }


updateASTS : AST -> List AST -> Model -> Model
updateASTS ast next model =
    let
        newASTS =
            { current = ast
            , next = next
            , prev = []
            }
    in
    { model | asts = Just newASTS }
