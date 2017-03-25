module View exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(CinemaScheduleMsg))
import Html exposing (Html, text)
import CinemaSchedule.View as CinemaScheduleView
import Routing exposing (parseLocation, Route(ScheduleRoute, NotFoundRoute))


view : Model -> Html Msg
view { cinemaSchedule, route } =
    case route of
        ScheduleRoute ->
            CinemaScheduleView.view cinemaSchedule
                |> Html.map CinemaScheduleMsg

        NotFoundRoute ->
            text "not found"
