module Main exposing (main)

import Browser
import Html.Styled as Html
import Http exposing (Error(..))
import Model exposing (Model)
import Msg exposing (Msg)
import Update
import View


main : Program () Model Msg
main =
    Browser.document
        { init = Model.init
        , update = Update.update
        , view =
            \m ->
                { title = "Simple interpreter"
                , body = [ Html.toUnstyled <| View.view m ]
                }
        , subscriptions = \_ -> Sub.none
        }
