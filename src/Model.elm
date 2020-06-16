module Model exposing (Model, init)

import Data.GenericASTState exposing (GenericASTState)
import Msg exposing (Msg)


type alias Model =
    { asts : Maybe GenericASTState
    , exprStr : String
    , parseButtonClicked : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { asts = Nothing
      , exprStr = ""
      , parseButtonClicked = False
      }
    , Cmd.none
    )
