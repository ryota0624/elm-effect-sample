module CinemaSchedule.Msg exposing (Msg(..))

import Types.Error exposing (Error)
import Types.Schedule exposing (Schedule)
import Date exposing (Date)


type Msg
    = ReceiveSchedule Schedule
    | RequestSchedule Date
    | FailRequestSchedule Error
