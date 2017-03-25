effect module Effects.ErrorEffect where { command = MyCmd, subscription = MySub } exposing (..)

import CinemaSchedule.Model
import Http exposing (Request)
import Platform exposing (sendToApp)
import Task exposing (Task)
import Types.Error exposing (Error)


type MyCmd msg
    = Publish Error


type MySub msg
    = Subscriber (Error -> msg)


type State
    = None


init : Task Never State
init =
    Task.succeed None


cmdMap : (a -> b) -> MyCmd a -> MyCmd b
cmdMap func (Publish tagger) =
    Publish tagger


subMap : (a -> b) -> MySub a -> MySub b
subMap func (Subscriber tagger) =
    Subscriber (tagger >> func)


subscribe : (Error -> msg) -> Sub msg
subscribe tagger =
    subscription (Subscriber tagger)


publish : Error -> Cmd msg
publish tagger =
    command (Publish tagger)


onEffects : Platform.Router a selfMsg -> List (MyCmd a) -> List (MySub a) -> State -> Task Never State
onEffects router commands subscribers state =
    case commands of
        (Publish error) :: rest ->
            Task.sequence (subscribers |> List.map (\(Subscriber fn) -> sendToApp router (fn error)))
                |> Task.andThen (\_ -> onEffects router rest subscribers state)

        [] ->
            Task.succeed state


onSelfMsg : Platform.Router appMsg selfMsg -> selfMsg -> State -> Task Never State
onSelfMsg _ _ state =
    Task.succeed state
