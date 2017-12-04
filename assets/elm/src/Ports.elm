port module Ports exposing (..)

-- OUT PORTS


port initRecaptcha : String -> Cmd msg



-- IN PORTS


port setRecaptchaToken : (String -> msg) -> Sub msg
