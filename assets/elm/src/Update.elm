module Update exposing (update)

import Http exposing (Error(..))
import Json.Decode as Decode
import Commands as Commands
import Decoders exposing (validationErrorsDecoder)
import Messages exposing (Msg(..))
import Model exposing (..)


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
                let
                    newSubscribeForm =
                        Saving formFields
                in
                    { model | subscribeForm = newSubscribeForm } ! [ Commands.subscribe newSubscribeForm ]

            SubscribeResponse (Ok result) ->
                { model | subscribeForm = Success } ! []

            SubscribeResponse (Err (BadStatus response)) ->
                case Decode.decodeString validationErrorsDecoder response.body of
                    Ok validationErrors ->
                        { model | subscribeForm = Invalid formFields validationErrors } ! []

                    Err error ->
                        { model | subscribeForm = Errored formFields "Oops! Something went wrong!" } ! []

            SubscribeResponse (Err error) ->
                { model | subscribeForm = Errored formFields "Oops! Something went wrong!" } ! []

            SetRecaptchaToken token ->
                { model | subscribeForm = Editing { formFields | recaptchaToken = Just token } } ! []
