defmodule LandingPage.Marketing.Lead do
  use Ecto.Schema
  import Ecto.Changeset
  alias LandingPage.Marketing.Lead

  @derive {Poison.Encoder, only: [:full_name, :email]}

  schema "leads" do
    field(:email, :string)
    field(:full_name, :string)

    field(:recaptcha_token, :string, virtual: true)

    timestamps()
  end

  @fields ~w(full_name email recaptcha_token)a

  @doc false
  def changeset(%Lead{} = lead, attrs) do
    lead
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:email)
  end
end
