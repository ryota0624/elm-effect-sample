module CinemaSchedule.View exposing (view)

import CinemaSchedule.Model exposing (Model)
import CinemaSchedule.Msg exposing (Msg)
import Html exposing (Html, text, img)
import Html.Attributes exposing (src)
import Types.Schedule exposing (MovieValueObject, Schedule)
import Bootstrap.Table as Table
import Date exposing (Date)


matchDate : Date -> Date -> Bool
matchDate a b =
    let
        year =
            Date.year a == Date.year b

        month =
            Date.month a == Date.month b

        day =
            Date.day a == Date.day b
    in
        year && month && day


view : Model -> Html Msg
view { currentShowDate, schedules } =
    schedules
        -- |> List.filter (\movie -> matchDate movie.date currentShowDate)
        |>
            List.head
        |> Maybe.map (\{ movies } -> movieList movies)
        |> Maybe.withDefault (noSchedule currentShowDate schedules)


noSchedule : Date -> List Schedule -> Html Msg
noSchedule date schedules =
    text <| "no movies" ++ (date |> toString) ++ (schedules |> List.length |> toString)


movieListHeader : Table.THead Msg
movieListHeader =
    Table.simpleThead
        [ Table.th [] [ text "Title" ]
        , Table.th [] [ text "Image" ]
        ]


movieList : List MovieValueObject -> Html Msg
movieList movies =
    Table.table
        { options = [ Table.striped, Table.hover ]
        , thead = movieListHeader
        , tbody = movieListBody movies
        }


movieListBody : List MovieValueObject -> Table.TBody Msg
movieListBody movies =
    Table.tbody
        []
        (movies
            |> List.map movieListTr
        )


movieListTr : MovieValueObject -> Table.Row Msg
movieListTr { title, thumbnaiUrl } =
    Table.tr []
        [ Table.td [] [ text title ]
        , Table.td [] [ img [ src <| "http://www.aeoncinema.com" ++ thumbnaiUrl ] [] ]
        ]
