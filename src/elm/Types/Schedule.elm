module Types.Schedule exposing (..)

import Json.Decode as Decode
import Monocle.Optional exposing (Optional)
import Monocle.Lens exposing (Lens)
import Date exposing (Date)


type alias Schedule =
    { date : Date
    , movies : List MovieValueObject
    }


moviesOfSchedule : Lens Schedule (List MovieValueObject)
moviesOfSchedule =
    let
        get schedule =
            schedule.movies

        set movies schedule =
            { schedule | movies = movies }
    in
        Lens get set


movieOfSchedule : MovieValueObjectID -> Optional Schedule MovieValueObject
movieOfSchedule id =
    let
        getOptional : Schedule -> Maybe MovieValueObject
        getOptional schedule =
            schedule.movies |> List.filter (\m -> m.id == id) |> List.head

        set : MovieValueObject -> Schedule -> Schedule
        set movie schedule =
            { schedule | movies = schedule.movies ++ [ movie ] }
    in
        Optional getOptional set


type alias MovieValueObjectID =
    String


type alias MovieValueObjectTitle =
    String


type alias MovieValueObject =
    { id : MovieValueObjectID
    , title : MovieValueObjectTitle
    , thumbnaiUrl : String
    , detailUrl : String
    }


decodeDateFromString : Decode.Decoder Date
decodeDateFromString =
    Decode.string
        |> Decode.andThen
            (Date.fromString
                >> (\res ->
                        case res of
                            Ok value ->
                                Decode.succeed value

                            Err reason ->
                                Decode.fail reason
                   )
            )


decodeSchedule : Decode.Decoder Schedule
decodeSchedule =
    Decode.map2 Schedule
        (Decode.field "date" decodeDateFromString)
        (Decode.field "movies" (Decode.list decodeModelDTO))


decodeModelDTO : Decode.Decoder MovieValueObject
decodeModelDTO =
    Decode.map4 MovieValueObject
        (Decode.field "id" Decode.string)
        (Decode.field "title" Decode.string)
        (Decode.field "thumbnail_url" Decode.string)
        (Decode.field "detail_url" Decode.string)
