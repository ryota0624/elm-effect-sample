module Msg exposing (Msg(..))

import Navigation exposing (Location)
import CinemaSchedule.Msg as CinemaSchedule
import Types.Error
import Types.Schedule


type Msg
    = CinemaScheduleMsg CinemaSchedule.Msg
    | OnLocationChange Location
    | Receive Types.Schedule.Schedule
    | ReceiveError Types.Error.Error
