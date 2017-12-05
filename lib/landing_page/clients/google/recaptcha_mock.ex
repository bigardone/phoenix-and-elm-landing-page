defmodule LandingPage.Clients.GoogleRecaptchaMock do
  @moduledoc """
  Google recaptcha mock client
  """

  def verify_site("invalid"), do: {:ok, %{success: false}}
  def verify_site(_token), do: {:ok, %{success: true}}
end
