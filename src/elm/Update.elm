module Update exposing (update, init, Flag)

import Model exposing (Model)
import Msg exposing (Msg(CinemaScheduleMsg, OnLocationChange, Receive, ReceiveError))
import CinemaSchedule.Update as CinemaScheduleUpdate
import Routing exposing (parseLocation, Route(ScheduleRoute))


type alias Flag =
    { cinemaScheduleFlag : CinemaScheduleUpdate.Flag
    }


init : Flag -> ( Model, Cmd Msg )
init { cinemaScheduleFlag } =
    let
        ( cinemaSchedule, cinemaScheduleCmd ) =
            (CinemaScheduleUpdate.init cinemaScheduleFlag) |> Tuple.mapSecond (Cmd.map CinemaScheduleMsg)
    in
        { cinemaSchedule = cinemaSchedule, route = ScheduleRoute } ! [ cinemaScheduleCmd ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CinemaScheduleMsg cinemaScheduleMsg ->
            let
                ( cinemaScheduleModel, cinemaSceduleCmd ) =
                    CinemaScheduleUpdate.update cinemaScheduleMsg model.cinemaSchedule |> Tuple.mapSecond (Cmd.map CinemaScheduleMsg)
            in
                { model | cinemaSchedule = cinemaScheduleModel } ! [ cinemaSceduleCmd ]

        OnLocationChange location ->
            { model | route = parseLocation location } ! []

        Receive schedule ->
            let
                a =
                    Debug.log "receive" schedule.date
            in
                model ! []

        ReceiveError error ->
            let
                a =
                    Debug.log "receive" error
            in
                model ! []
