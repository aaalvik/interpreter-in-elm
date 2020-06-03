module TestParser exposing (unitTest)

import Data.AST exposing (AST(..))
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (..)
import Parser.Parser as Parser
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag, text)


{-| See <https://github.com/elm-community/elm-test>
-}
unitTest : Test
unitTest =
    describe "parser"
        [ test "Parse sant" <|
            \_ ->
                "sant"
                    |> Parser.parse
                    |> Expect.equal (Ok Sant)
        , test "Parse usant" <|
            \_ ->
                "usant"
                    |> Parser.parse
                    |> Expect.equal (Ok Usant)
        ]
