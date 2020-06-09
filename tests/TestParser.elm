module TestParser exposing (unitTest)

import Data.AST exposing (AST(..))
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Interpreter.Parser as Parser
import Main exposing (..)
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
                    |> Expect.equal (Just Sant)
        , test "Parse usant" <|
            \_ ->
                "usant"
                    |> Parser.parse
                    |> Expect.equal (Just Usant)
        , test "Parse _eller ikke sant usant_" <|
            \_ ->
                "eller ikke sant usant"
                    |> Parser.parse
                    |> Expect.equal (Just <| Eller (Ikke Sant) Usant)
        ]
