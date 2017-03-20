module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(None))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )
