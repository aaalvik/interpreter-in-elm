module TestParser exposing (fuzzTest, unitTest, viewTest)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (..)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag, text)


{-| See <https://github.com/elm-community/elm-test>
-}
unitTest : Test
unitTest =
    describe "parser"
        [ test "Parse false" <|
            \_ ->
                "false"
                    |> Parser.parse
                    |> Expect.equal ()
        ]
