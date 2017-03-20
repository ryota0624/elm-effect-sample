module Main exposing (..)

import Html exposing (..)


type alias Model =
    {}


type Msg
    = None


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


main : Program Never {} Msg
main =
    program
        { init = ( {}, Cmd.none )
        , view = (\m -> Html.text "hello, elm!")
        , update = update
        , subscriptions = subscriptions
        }
