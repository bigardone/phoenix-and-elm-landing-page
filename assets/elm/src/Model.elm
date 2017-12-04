module Model exposing (..)

import Dict exposing (Dict)


type alias FormFields =
    { fullName : String
    , email : String
    , recaptchaToken : Maybe String
    }


type alias ValidationErrors =
    Dict String (List String)


type SubscribeForm
    = Editing FormFields
    | Saving FormFields
    | Invalid FormFields ValidationErrors
    | Success FormFields


type alias Model =
    { subscribeForm : SubscribeForm }


extractFormFields : SubscribeForm -> FormFields
extractFormFields subscribeForm =
    case subscribeForm of
        Editing ff ->
            ff

        Saving ff ->
            ff

        Invalid ff _ ->
            ff

        Success ff ->
            ff


extractValidationErrors : SubscribeForm -> ValidationErrors
extractValidationErrors subscribeForm =
    case subscribeForm of
        Invalid _ validationErrors ->
            validationErrors

        _ ->
            emptyValidationErrors


emptyValidationErrors : ValidationErrors
emptyValidationErrors =
    Dict.empty
