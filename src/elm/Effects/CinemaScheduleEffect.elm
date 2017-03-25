effect module Effects.CinemaScheduleEffect where { command = MyCmd, subscription = MySub } exposing (..)

import CinemaSchedule.Model
import Http exposing (Request)
import Platform exposing (sendToApp)
import Task exposing (Task)
import Types.Schedule exposing (decodeSchedule)


type MyCmd msg
    = Publish Types.Schedule.Schedule


type MySub msg
    = Subscriber (Types.Schedule.Schedule -> msg)


type alias State msg =
    { subscribers : List (Types.Schedule.Schedule -> msg) }


init : Task Never (State msg)
init =
    Task.succeed { subscribers = [] }


cmdMap : (a -> b) -> MyCmd a -> MyCmd b
cmdMap func (Publish tagger) =
    Publish tagger


subMap : (a -> b) -> MySub a -> MySub b
subMap func (Subscriber tagger) =
    Subscriber (tagger >> func)


subscribe : (Types.Schedule.Schedule -> msg) -> Sub msg
subscribe tagger =
    subscription (Subscriber tagger)


publish : Types.Schedule.Schedule -> Cmd msg
publish tagger =
    command (Publish tagger)


onEffects : Platform.Router a selfMsg -> List (MyCmd a) -> List (MySub a) -> State a -> Task Never (State a)
onEffects router commands subscribers state =
    case commands of
        (Publish schedule) :: rest ->
            Task.sequence (subscribers |> List.map (\(Subscriber fn) -> sendToApp router (fn schedule)))
                |> Task.andThen (\_ -> onEffects router rest subscribers state)

        [] ->
            Task.succeed state


onSelfMsg : Platform.Router appMsg selfMsg -> selfMsg -> State msg -> Task Never (State msg)
onSelfMsg _ _ state =
    Task.succeed state
