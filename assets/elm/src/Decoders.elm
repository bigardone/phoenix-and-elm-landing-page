module Decoders exposing (..)

import Dict exposing (Dict)
import Json.Decode as Decode
import Model exposing (ValidationErrors)


responseDecoder : Decode.Decoder (Dict String String)
responseDecoder =
    Decode.dict Decode.string


validationErrorsDecoder : Decode.Decoder ValidationErrors
validationErrorsDecoder =
    Decode.dict <| Decode.list Decode.string
