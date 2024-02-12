defmodule MishkaPubTest.User.CreateTest do
  use ExUnit.Case
  alias ActivityPub.User.Create

  # Initial data
  @correct_actor_data %{
    type: "Organization",
    name: "Mishka",
    email: "shahryar@mishka.life",
    preferredUsername: "mishka",
    mobile: "00989368094936",
    summary:
      "Mishka is a highly agile software group combining care and technology to help local businesses thrive."
  }

  # -------------------------------------------------------------------------------------- #
  describe "Happy way| create a user as an actor (▰˘◡˘▰)" do
    test "register a user with full params" do
      {:ok, %ActivityPub.User.Create{}} = assert Create.builder(@correct_actor_data)
    end

    test "register a user with enforce params" do
      {:ok, %ActivityPub.User.Create{}} =
        assert Create.builder(Map.drop(@correct_actor_data, [:type, :mobile, :summary]))
    end
  end

  # -------------------------------------------------------------------------------------- #
  describe "UnHappy way| create a user as an actor ಠ╭╮ಠ" do
    test "register a user with bad username" do
      {:error, _error} =
        assert Create.builder(Map.merge(@correct_actor_data, %{preferredUsername: "mishka 1"}))
    end

    test "register a user with bad params" do
      {:error, _error} =
        assert Create.builder(Map.merge(@correct_actor_data, %{email: "mishka 1"}))

      merged_email =
        Map.merge(@correct_actor_data, %{email: "mishka@testdomainfortes.com"})

      {:error, _error} = assert Create.builder(merged_email)
    end

    test "register a user with missing enforce params" do
      {:error, _error} =
        assert Create.builder(Map.drop(@correct_actor_data, [:name, :email, :preferredUsername]))
    end
  end
end
