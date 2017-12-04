module Messages exposing (Msg(..))

import Dict exposing (Dict)
import Http


type Msg
    = HandleFullNameInput String
    | HandleEmailInput String
    | HandleFormSubmit
    | SubscribeResponse (Result Http.Error (Dict String String))
    | SetRecaptchaToken String
