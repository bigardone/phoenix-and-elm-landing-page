module Model exposing (FormFields, Model, SubscribeForm(..), ValidationErrors, emptyFormFields, emptyValidationErrors, extractFormFields, extractValidationErrors, initialModel)

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
    | Errored FormFields String
    | Success


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

        Errored ff _ ->
            ff

        Success ->
            emptyFormFields


emptyFormFields : FormFields
emptyFormFields =
    { fullName = ""
    , email = ""
    , recaptchaToken = Nothing
    }


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


initialModel : Model
initialModel =
    { subscribeForm = Editing emptyFormFields }
