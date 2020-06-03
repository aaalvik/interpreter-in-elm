module Data.GenericAST exposing (Children(..), GenericAST, nodeWidth, treeWidth)


type alias GenericAST =
    { name : String
    , children : Children
    }


type Children
    = Children (List GenericAST)


treeWidth : GenericAST -> Int
treeWidth ast =
    let
        (Children children) =
            ast.children

        margin =
            (List.length children - 1) * marginBetween
    in
    if List.isEmpty children then
        nodeWidth ast.name

    else
        margin + (List.sum <| List.map treeWidth children)


nodeWidth : String -> Int
nodeWidth name =
    String.length name * wFACTOR + 10


marginBetween : Int
marginBetween =
    40


wFACTOR : Int
wFACTOR =
    11
