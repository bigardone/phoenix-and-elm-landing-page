defmodule LandingPageWeb.ErrorView do
  use LandingPageWeb, :view

  import LandingPageWeb.ErrorHelpers

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  def render("error.json", %{changeset: changeset}) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("invalid_recaptcha_token.json", _) do
    %{recaptcha_token: ["invalid"]}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end
end
