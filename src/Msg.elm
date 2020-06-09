module Msg exposing (Msg(..))


type Msg
    = SetExprStr String
    | ParseAndEvaluateStr
    | NextState
    | PreviousState
    | KeyDown Int
