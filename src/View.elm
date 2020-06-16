module View exposing (view)

import Data.GenericAST exposing (GenericAST)
import Html as Unstyled
import Html.Attributes as Unstyled
import Html.Events as Unstyled exposing (keyCode, on, onClick, onInput)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attributes exposing (class, placeholder)
import Html.Styled.Events as Events
import Json.Decode as Json
import Model exposing (Model)
import Msg exposing (Msg(..))
import View.Tree as Tree


view : Model -> Html.Html Msg
view model =
    Html.div
        [ Attributes.class "page"
        ]
        [ Html.div [ Attributes.class "content" ]
            [ Html.div [ Attributes.class "top-container" ] viewTop
            , viewBottom model
            ]
        ]


viewTop : List (Html.Html Msg)
viewTop =
    [ Html.div [ Attributes.class "input-container" ]
        [ textInput KeyDown SetExprStr ]
    , Html.div [ Attributes.class "buttons" ]
        [ Html.button
            [ Attributes.class "button btn"
            , Events.onClick ParseAndEvaluateStr
            ]
            [ Html.text "Parse" ]
        , Html.button
            [ Attributes.class "button btn"
            , Events.onClick PreviousState
            ]
            [ Html.text "Forrige" ]
        , Html.button
            [ Attributes.class "button btn"
            , Events.onClick NextState
            ]
            [ Html.text "Neste" ]
        ]
    ]


viewBottom : Model -> Html.Html Msg
viewBottom model =
    Html.div [ Attributes.class "ast-container" ]
        [ viewLeftMenu
        , model.asts
            |> Maybe.map (viewAST << .current)
            |> Maybe.withDefault
                (if model.parseButtonClicked then
                    text "Ugyldig"

                 else
                    text ""
                )
        ]



-- HELPERS


viewAST : GenericAST -> Html.Html msg
viewAST ast =
    Html.fromUnstyled <|
        Unstyled.div [ Unstyled.class "tree-container" ]
            [ Tree.drawTree ast ]


viewLeftMenu : Html msg
viewLeftMenu =
    div [ class "left-menu" ] <|
        [ div [ class "grammar-container" ]
            [ strong [] [ text "Grammatikk: " ]
            , p [ class "code-font" ] [ text "S -> sant" ]
            , ul [ class "grammar-list code-font" ]
                [ li [] [ text "| usant" ]
                , li [] [ text "| ikke S" ]
                , li [] [ text "| og S S" ]
                , li [] [ text "| eller S S" ]
                ]
            ]
        ]


textInput : (Int -> msg) -> (String -> msg) -> Html.Html msg
textInput keyDown msg =
    Html.fromUnstyled <|
        Unstyled.input
            [ Unstyled.class "input expr-input"
            , Unstyled.placeholder "Skriv uttrykk her"
            , Unstyled.onInput msg
            , onKeyDown keyDown
            ]
            []


onKeyDown : (Int -> msg) -> Unstyled.Attribute msg
onKeyDown tagger =
    Unstyled.on "keydown" (Json.map tagger keyCode)
