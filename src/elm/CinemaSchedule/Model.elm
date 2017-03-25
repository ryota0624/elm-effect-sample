module CinemaSchedule.Model exposing (Model)

import Types.Schedule exposing (Schedule)
import Date exposing (Date)


type alias Model =
    { schedules : List Schedule
    , currentShowDate : Date
    }
