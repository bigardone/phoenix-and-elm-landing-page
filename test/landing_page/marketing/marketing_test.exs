defmodule LandingPage.MarketingTest do
  use LandingPage.DataCase

  alias LandingPage.Marketing

  describe "leads" do
    alias LandingPage.Marketing.Lead

    @valid_attrs %{email: "some email", full_name: "some full_name"}
    @update_attrs %{email: "some updated email", full_name: "some updated full_name"}
    @invalid_attrs %{email: nil, full_name: nil}

    def lead_fixture(attrs \\ %{}) do
      {:ok, lead} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketing.create_lead()

      lead
    end

    test "list_leads/0 returns all leads" do
      lead = lead_fixture()
      assert Marketing.list_leads() == [lead]
    end

    test "get_lead!/1 returns the lead with given id" do
      lead = lead_fixture()
      assert Marketing.get_lead!(lead.id) == lead
    end

    test "create_lead/1 with valid data creates a lead" do
      assert {:ok, %Lead{} = lead} = Marketing.create_lead(@valid_attrs)
      assert lead.email == "some email"
      assert lead.full_name == "some full_name"
    end

    test "create_lead/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketing.create_lead(@invalid_attrs)
    end

    test "update_lead/2 with valid data updates the lead" do
      lead = lead_fixture()
      assert {:ok, lead} = Marketing.update_lead(lead, @update_attrs)
      assert %Lead{} = lead
      assert lead.email == "some updated email"
      assert lead.full_name == "some updated full_name"
    end

    test "update_lead/2 with invalid data returns error changeset" do
      lead = lead_fixture()
      assert {:error, %Ecto.Changeset{}} = Marketing.update_lead(lead, @invalid_attrs)
      assert lead == Marketing.get_lead!(lead.id)
    end

    test "delete_lead/1 deletes the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{}} = Marketing.delete_lead(lead)
      assert_raise Ecto.NoResultsError, fn -> Marketing.get_lead!(lead.id) end
    end

    test "change_lead/1 returns a lead changeset" do
      lead = lead_fixture()
      assert %Ecto.Changeset{} = Marketing.change_lead(lead)
    end
  end
end
