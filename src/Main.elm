module Main exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Color exposing (Color)
import Update.Extra as Update
import Elegant exposing (vh, px)
import Style
import Box
import Block
import Flex
import Cursor
import Constants
import Display


{- Colors to improve the standard predefined colors of HTML.
   This example consists of a button, switching color when you click on it.
   It aims to provide the foundation of every application built with
   BodyBuilder and Elegant.
   Just clone, go in the folder, and use elm-github-install to get the packages.
-}


blue : Color
blue =
    Color.rgb 33 150 244


red : Color
red =
    Color.rgb 244 67 54


green : Color
green =
    Color.rgb 76 175 80


type alias Model =
    { color : Color }


setColorIn : Model -> Color -> Model
setColorIn model color =
    { model | color = color }


type Msg
    = ChangeColor


main : Program Never Model Msg
main =
    Builder.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    Model red ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ color } as model) =
    case msg of
        ChangeColor ->
            color
                |> changeColor
                |> setColorIn model
                |> Update.identity


changeColor : Color -> Color
changeColor color =
    if color == red then
        blue
    else if color == blue then
        green
    else
        red


view : Model -> Node Msg
view { color } =
    Builder.node
        [ Attributes.style [ Style.block [ windowHeight ] ] ]
        [ Builder.flex
            [ Attributes.style
                [ Style.block [ windowHeight ]
                , Style.box [ Box.systemFont "Verdana" ]
                , Style.flexContainerProperties
                    [ Flex.center
                    , Flex.direction Flex.column
                    ]
                ]
            ]
            [ Builder.flexItem [ paddingMedium ]
                [ Builder.div [] [ Builder.text "The button change its color when you click it!" ] ]
            , Builder.flexItem [ paddingMedium ]
                [ Builder.button
                    [ Events.onClick ChangeColor
                    , Attributes.style
                        [ Style.box
                            [ Box.backgroundColor color
                            , Box.borderNone
                            , Box.cornerRound
                            , Box.paddingAll Constants.medium
                            , Box.outlineNone
                            , Box.cursor Cursor.pointer
                            , Box.textColor Color.white
                            ]
                        ]
                    ]
                    [ Builder.text "Click me!" ]
                ]
            ]
        ]


windowHeight : Elegant.Modifier Display.BlockDetails
windowHeight =
    Block.height (vh 100)


paddingMedium : Elegant.Modifier (Attributes.BoxContainer extendable)
paddingMedium =
    Attributes.style [ Style.box [ Box.paddingAll Constants.medium ] ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
