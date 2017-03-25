module Types.Error exposing (Error(..))

import Http


type Error
    = Http Http.Error
