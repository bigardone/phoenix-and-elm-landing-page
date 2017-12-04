module Messages exposing (Msg(..))

import Http


type Msg
    = HandleFullNameInput String
    | HandleEmailInput String
    | HandleFormSubmit
    | SubscribeResponse (Result Http.Error Bool)
    | SetRecaptchaToken String
