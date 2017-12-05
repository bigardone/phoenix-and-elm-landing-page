defmodule LandingPageWeb.FallbackController do
  use LandingPageWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(LandingPageWeb.ErrorView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :invalid_recaptcha_token}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(LandingPageWeb.ErrorView, "invalid_recaptcha_token.json")
  end
end
