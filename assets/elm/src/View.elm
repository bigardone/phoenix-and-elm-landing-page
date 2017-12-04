module View exposing (view)

import Dict exposing (Dict)
import Html exposing (Html, form)
import Html.Attributes as Html
import Html.Events as Html
import Messages exposing (Msg(..))
import Model exposing (..)


view : Model -> Html Msg
view { subscribeForm } =
    case subscribeForm of
        Success ->
            Html.div
                [ Html.class "success-message" ]
                [ Html.div
                    [ Html.class "icon is-large" ]
                    [ Html.i
                        [ Html.class "fa fa-3x fa-heart" ]
                        []
                    ]
                , Html.h2
                    []
                    [ Html.text "You have subscribed with success" ]
                , Html.p
                    []
                    [ Html.text "We will keep you updated with the latest news" ]
                ]

        _ ->
            formView subscribeForm


formView : SubscribeForm -> Html Msg
formView subscribeForm =
    let
        { fullName, email } =
            extractFormFields subscribeForm

        validationErrors =
            extractValidationErrors subscribeForm

        saving =
            case subscribeForm of
                Saving _ ->
                    True

                _ ->
                    False

        invalid =
            case subscribeForm of
                Invalid _ _ ->
                    True

                _ ->
                    False

        buttonDisabled =
            fullName
                == ""
                || email
                == ""
                || saving
                || invalid
    in
        Html.div
            [ Html.class "content" ]
            [ Html.h3
                []
                [ Html.text "Want to know more?" ]
            , Html.p
                []
                [ Html.text "Subscribe to stay updated" ]
            , formError subscribeForm
            , form
                [ Html.onSubmit HandleFormSubmit ]
                [ Html.div
                    [ Html.class "field" ]
                    [ Html.div
                        [ Html.class "control" ]
                        [ Html.input
                            [ Html.classList
                                [ ( "input is-medium", True )
                                , ( "is-danger", Dict.member "full_name" validationErrors )
                                ]
                            , Html.placeholder "My name is..."
                            , Html.required True
                            , Html.value fullName
                            , Html.onInput HandleFullNameInput
                            ]
                            []
                        , validationErrorView "full_name" validationErrors
                        ]
                    ]
                , Html.div
                    [ Html.class "field" ]
                    [ Html.div
                        [ Html.class "control" ]
                        [ Html.input
                            [ Html.classList
                                [ ( "input is-medium", True )
                                , ( "is-danger", Dict.member "email" validationErrors )
                                ]
                            , Html.type_ "email"
                            , Html.placeholder "My email address is..."
                            , Html.required True
                            , Html.value email
                            , Html.onInput HandleEmailInput
                            ]
                            []
                        , validationErrorView "email" validationErrors
                        ]
                    ]
                , Html.div
                    [ Html.class "field" ]
                    [ Html.div
                        [ Html.id "recaptcha" ]
                        []
                    , validationErrorView "recaptcha_token" validationErrors
                    ]
                , Html.div
                    [ Html.class "field" ]
                    [ Html.div
                        [ Html.class "control" ]
                        [ Html.button
                            [ Html.class "button is-primary is-medium"
                            , Html.disabled buttonDisabled
                            ]
                            [ Html.span
                                [ Html.class "icon" ]
                                [ Html.i
                                    [ Html.classList
                                        [ ( "fa fa-check", not saving )
                                        , ( "fa fa-circle-o-notch fa-spin", saving )
                                        ]
                                    ]
                                    []
                                ]
                            , Html.span
                                []
                                [ Html.text "Subscribe me" ]
                            ]
                        ]
                    ]
                ]
            ]


validationErrorView : String -> ValidationErrors -> Html Msg
validationErrorView key validationErrors =
    case Dict.get key validationErrors of
        Just error ->
            error
                |> List.map Html.text
                |> Html.p
                    [ Html.class "help is-danger" ]

        Nothing ->
            Html.text ""


formError : SubscribeForm -> Html Msg
formError subscribeForm =
    case subscribeForm of
        Errored _ message ->
            Html.div
                [ Html.class "notification is-danger fade-in" ]
                [ Html.text message ]

        _ ->
            Html.text ""
