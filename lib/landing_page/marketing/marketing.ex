defmodule LandingPage.Marketing do
  @moduledoc """
  The Marketing context.
  """

  alias LandingPage.Repo

  alias LandingPage.Marketing.Lead

  @doc """
  Creates a lead.

  ## Examples

      iex> create_lead(%{field: value})
      {:ok, %Lead{}}

      iex> create_lead(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lead(attrs \\ %{}) do
    %Lead{}
    |> Lead.changeset(attrs)
    |> Repo.insert()
  end
end
