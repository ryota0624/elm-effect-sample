module Utils.ExHttp exposing (errToString)

import Http exposing (Error(..))


errToString : Error -> String
errToString error =
    case error of
        BadUrl url ->
            url ++ "BadUrl"

        Timeout ->
            "Timeout"

        NetworkError ->
            "NetworkError"

        BadStatus response ->
            "BadStatus"

        BadPayload str response ->
            "BadPayload"
