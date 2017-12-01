defmodule LandingPageWeb.FallbackController do
  use LandingPageWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(LandingPageWeb.ErrorView, "error.json", changeset: changeset)
  end
end
