module Parser.Parser exposing (parse)

import Data.AST exposing (AST(..))
import Parser exposing ((|.), (|=), Parser)


parse : String -> Result (List Parser.DeadEnd) AST
parse expr =
    Parser.run parser expr


parser : Parser AST
parser =
    Parser.oneOf
        [ Parser.succeed Sant
            |. Parser.keyword "sant"
        , Parser.succeed Usant
            |. Parser.keyword "usant"
        ]
