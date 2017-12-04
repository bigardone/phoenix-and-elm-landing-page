module Update exposing (update)

import Http exposing (Error(..))
import Json.Decode as Decode
import Commands as Commands
import Decoders exposing (validationErrorsDecoder)
import Messages exposing (Msg(..))
import Model exposing (..)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        subscribeForm =
            model.subscribeForm

        formFields =
            extractFormFields model.subscribeForm
    in
        case msg of
            HandleFullNameInput value ->
                { model | subscribeForm = Editing { formFields | fullName = value } } ! []

            HandleEmailInput value ->
                { model | subscribeForm = Editing { formFields | email = value } } ! []

            HandleFormSubmit ->
                { model | subscribeForm = Saving formFields } ! [ Commands.subscribe subscribeForm ]

            SubscribeResponse (Ok result) ->
                { model | subscribeForm = Success formFields } ! []

            SubscribeResponse (Err (BadStatus response)) ->
                case Decode.decodeString validationErrorsDecoder response.body of
                    Ok validationErrors ->
                        { model | subscribeForm = Invalid formFields validationErrors } ! [ Ports.resetRecaptcha () ]

                    Err error ->
                        { model | subscribeForm = Invalid formFields emptyValidationErrors } ! [ Ports.resetRecaptcha () ]

            SubscribeResponse (Err error) ->
                { model | subscribeForm = Invalid formFields emptyValidationErrors } ! [ Ports.resetRecaptcha () ]

            SetRecaptchaToken token ->
                { model | subscribeForm = Editing { formFields | recaptchaToken = Just token } } ! []
