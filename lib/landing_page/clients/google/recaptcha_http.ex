defmodule LandingPage.Clients.GoogleRecaptchaHttp do
  @moduledoc """
  Google recaptcha http client
  """

  use HTTPoison.Base

  @secret_key Application.get_env(:landing_page, :google_recaptcha_secret)

  def verify_site(token) do
    params = %{
      secret: @secret_key,
      response: token
    }

    "/siteverify"
    |> get!([], params: params)
    |> case do
         %{status_code: 200, body: body} ->
           {:ok, body}

         response ->
           {:error, response}
       end
  end

  def process_url(url) do
    "https://www.google.com/recaptcha/api" <> url
  end

  def process_response_body(body), do: Poison.decode!(body, keys: :atoms)
end
