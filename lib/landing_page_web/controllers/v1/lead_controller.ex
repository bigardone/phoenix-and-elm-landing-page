defmodule LandingPageWeb.V1.LeadController do
  use LandingPageWeb, :controller

  alias LandingPage.Marketing

  plug(:scrub_params, "lead")

  def create(conn, %{"lead" => params}) do
    with {:ok, lead} <- Marketing.create_lead(params) do
      json(conn, lead)
    end
  end
end
