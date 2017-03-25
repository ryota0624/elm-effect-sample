module Model exposing (Model)

import CinemaSchedule.Model as CinemaSchedule
import Routing exposing (Route)


type alias Model =
    { cinemaSchedule : CinemaSchedule.Model
    , route : Route
    }
