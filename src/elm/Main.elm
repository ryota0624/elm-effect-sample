module Main exposing (..)

import Html exposing (..)
import Msg exposing (Msg)
import Update exposing (update)
import Subscriptions exposing (subscriptions)


main : Program Never {} Msg
main =
    program
        { init = ( {}, Cmd.none )
        , view = (\m -> Html.text "hello, elm!")
        , update = update
        , subscriptions = subscriptions
        }
