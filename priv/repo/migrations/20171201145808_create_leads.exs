defmodule LandingPage.Repo.Migrations.CreateLeads do
  use Ecto.Migration

  def change do
    create table(:leads) do
      add(:full_name, :string, null: false)
      add(:email, :string, null: false)

      timestamps()
    end

    create(unique_index(:leads, [:email]))
  end
end
