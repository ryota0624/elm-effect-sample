module Subscriptions exposing (..)

import Effects.CinemaScheduleEffect as CinemaScheduleEffect
import Effects.ErrorEffect as ErrorEffect
import Model exposing (Model)
import Msg exposing (Msg(Receive, ReceiveError))


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ CinemaScheduleEffect.subscribe Receive
        , ErrorEffect.subscribe ReceiveError
        ]
