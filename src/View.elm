module View exposing (view)

import Data.GenericAST exposing (GenericAST)
import Html exposing (..)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Json.Decode as Json
import Model exposing (Model)
import Msg exposing (Msg(..))
import View.Tree as Tree


view : Model -> Html Msg
view model =
    div [ class "page" ]
        [ div [ class "content" ]
            [ div [ class "top-container" ] viewTop
            , viewBottom model
            ]
        ]


viewTop : List (Html Msg)
viewTop =
    [ div [ class "input-container" ]
        [ textInput "Skriv uttrykk her" "expr-input" KeyDown SetExprStr ]
    , div [ class "buttons" ]
        [ button [ class "button btn", onClick ParseStr ] [ text "Parse" ]
        , button [ class "button btn", onClick PreviousState ] [ text "Forrige" ]
        , button [ class "button btn", onClick NextState ] [ text "Neste" ]
        ]
    ]


viewBottom : Model -> Html Msg
viewBottom model =
    div [ class "ast-container" ]
        [ viewLeftMenu
        , model.asts
            |> Maybe.map (viewAST << .current)
            |> Maybe.withDefault (text "Ugyldig")
        ]



-- HELPERS


viewAST : GenericAST -> Html msg
viewAST ast =
    div [ class "tree-container" ]
        [ Tree.drawTree ast ]


viewLeftMenu : Html msg
viewLeftMenu =
    div [ class "left-menu" ] <|
        [ div [ class "grammar-container" ]
            [ strong [] [ text "Grammatikk: " ]
            , p [ class "code-font" ] [ text "S -> * S S" ]
            , ul [ class "grammar-list code-font" ]
                [ li [] [ text "| + S S" ]
                , li [] [ text "| - S" ]
                , li [] [ text "| if S then S else S" ]
                , li [] [ text "| number" ]
                ]
            ]
        ]


textInput : String -> String -> (Int -> msg) -> (String -> msg) -> Html msg
textInput str className keyDown msg =
    input
        [ class <| "input " ++ className
        , placeholder str
        , onInput msg
        , onKeyDown keyDown
        ]
        []


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)
