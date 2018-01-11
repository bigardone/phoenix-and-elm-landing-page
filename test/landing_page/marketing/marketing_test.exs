defmodule LandingPage.MarketingTest do
  use LandingPage.DataCase

  alias LandingPage.Marketing

  describe "leads" do
    alias LandingPage.Marketing.Lead

    @valid_attrs %{
      "email" => "some email",
      "full_name" => "some full_name",
      "recaptcha_token" => "foo"
    }
    @invalid_attrs %{email: nil, full_name: nil, recaptcha_token: nil}

    def lead_fixture(attrs \\ %{}) do
      {:ok, lead} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Marketing.create_lead()

      lead
    end

    test "create_lead/1 with valid data creates a lead" do
      assert {:ok, %Lead{} = lead} = Marketing.create_lead(@valid_attrs)
      assert lead.email == "some email"
      assert lead.full_name == "some full_name"
    end

    test "create_lead/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Marketing.create_lead(@invalid_attrs)
    end

    test "subscribe/1 with valid data and token creates a lead" do
      assert {:ok, %Lead{}} = Marketing.subscribe(@valid_attrs)
    end

    test "subscribe/1 with invalid token returns error changeset" do
      params = %{@valid_attrs | "recaptcha_token" => "invalid"}
      assert {:error, :invalid_recaptcha_token} = Marketing.subscribe(params)
    end
  end
end
