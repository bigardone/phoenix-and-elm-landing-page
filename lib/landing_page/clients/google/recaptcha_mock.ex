defmodule LandingPage.Clients.GoogleRecaptchaMock do
  @moduledoc """
  Google recaptcha mock client
  """

  def verify("invalid"), do: {:ok, %{success: false}}
  def verify(_token), do: {:ok, %{success: true}}
end
