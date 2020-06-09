module Interpreter.Parser exposing (parse)

import Data.AST exposing (AST(..))
import Parser exposing ((|.), (|=), Parser)


parse : String -> Maybe AST
parse expr =
    Parser.run parser expr
        |> Result.toMaybe


parser : Parser AST
parser =
    Parser.oneOf
        [ Parser.succeed Sant
            |. Parser.keyword "sant"
        , Parser.succeed Usant
            |. Parser.keyword "usant"
        , ikkeParser
        , ogParser
        , ellerParser
        ]


ikkeParser : Parser AST
ikkeParser =
    Parser.succeed Ikke
        |. Parser.keyword "ikke"
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.end


ogParser : Parser AST
ogParser =
    Parser.succeed Og
        |. Parser.keyword "og"
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.end


ellerParser : Parser AST
ellerParser =
    Parser.succeed Eller
        |. Parser.keyword "eller"
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.spaces
        |= Parser.lazy (\_ -> parser)
        |. Parser.end
