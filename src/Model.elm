module Model exposing (Model, init)

import Data.ASTState exposing (ASTState)
import Msg exposing (Msg)


type alias Model =
    { asts : Maybe ASTState
    , exprStr : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { asts = Nothing
      , exprStr = ""
      }
    , Cmd.none
    )
