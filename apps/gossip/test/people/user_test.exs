defmodule People.UserTest do
  use Gossip.DataCase

  alias People.User

  describe "users" do

    @valid_attrs %{user_name: "xyz", description: "xyz desc", is_active: true, is_deleted: false}
    @updated_attrs %{user_name: "klm", description: "klm desc", is_active: false, is_deleted: true}
    @invalid_attrs %{user_name: nil, description: nil, is_active: nil, is_deleted: nil}

    test "empty list of users" do

    end

    test "create and retrieve a user" do
      user = %People.User{}
      changeset = People.User.changeset(user, @valid_attrs)
      assert {:ok, %User{} = inserted} = Gossip.Repo.insert(changeset)

      assert inserted.user_name == "xyz"
      assert inserted.description == "xyz desc"
      assert inserted.is_active == true
      assert inserted.is_deleted == false
    end
  end
end
