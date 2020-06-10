module Interpreter.Parser exposing (parse)

import Data.AST exposing (AST(..))
import Parser exposing ((|.), (|=), Parser)


parse : String -> Maybe AST
parse expr =
    let
        topLevelParser =
            Parser.succeed identity
                |= parser
                |. Parser.end
    in
    Parser.run topLevelParser expr
        |> Result.toMaybe


parser : Parser AST
parser =
    Parser.oneOf
        [ Parser.succeed Sant
            |. Parser.keyword "sant"
        , Parser.succeed Usant
            |. Parser.keyword "usant"
        , Parser.lazy (\_ -> ogParser)
        , Parser.lazy (\_ -> ellerParser)
        , Parser.lazy (\_ -> ikkeParser)
        ]


ikkeParser : Parser AST
ikkeParser =
    Parser.succeed Ikke
        |. Parser.keyword "ikke"
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)


ogParser : Parser AST
ogParser =
    Parser.succeed Og
        |. Parser.keyword "og"
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)


ellerParser : Parser AST
ellerParser =
    Parser.succeed Eller
        |. Parser.keyword "eller"
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
