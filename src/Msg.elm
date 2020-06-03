module Msg exposing (Msg(..))


type Msg
    = SetExprStr String
    | ParseStr
    | NextState
    | PreviousState
    | KeyDown Int
