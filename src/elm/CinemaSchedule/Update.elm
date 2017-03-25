module CinemaSchedule.Update exposing (update, init, Flag)

import CinemaSchedule.Msg exposing (Msg(ReceiveSchedule, RequestSchedule, FailRequestSchedule))
import CinemaSchedule.Model exposing (Model)
import Http
import Types.Schedule exposing (decodeSchedule)
import Utils.ExHttp exposing (errToString)
import Date
import Effects.CinemaScheduleEffect as CinemaScheduleEffect
import Effects.ErrorEffect as ErrorEffect
import Types.Error exposing (Error(Http))


type alias Flag =
    { time : Float }


init : Flag -> ( Model, Cmd Msg )
init { time } =
    Model [] (Date.fromTime time) ! [ getSchedule ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveSchedule schedule ->
            { model | schedules = model.schedules ++ [ schedule ] } ! [ CinemaScheduleEffect.publish schedule ]

        RequestSchedule date ->
            model ! []

        FailRequestSchedule error ->
            model ! [ ErrorEffect.publish error ]


getSchedule : Cmd Msg
getSchedule =
    let
        url =
            "/schedule"

        receiveResult =
            \result ->
                case result of
                    Ok value ->
                        ReceiveSchedule value

                    Err reason ->
                        FailRequestSchedule (Http reason)
    in
        Http.send receiveResult (Http.get url decodeSchedule)
