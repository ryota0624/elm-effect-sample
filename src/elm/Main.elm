module Main exposing (..)

import Msg exposing (Msg(OnLocationChange))
import Update exposing (update, init)
import Subscriptions exposing (subscriptions)
import View exposing (view)
import Model
import Navigation


start : Update.Flag -> a -> ( Model.Model, Cmd Msg )
start flag location =
    init flag


main : Program Update.Flag Model.Model Msg
main =
    Navigation.programWithFlags OnLocationChange
        { init = start
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
