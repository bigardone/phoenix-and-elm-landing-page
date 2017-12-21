module Decoders exposing (..)

import Json.Decode as Decode
import Model exposing (ValidationErrors)


responseDecoder : Decode.Decoder Bool
responseDecoder =
    Decode.succeed True


validationErrorsDecoder : Decode.Decoder ValidationErrors
validationErrorsDecoder =
    Decode.dict <| Decode.list Decode.string
