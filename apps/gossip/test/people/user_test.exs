defmodule People.UserTest do
  use Gossip.DataCase

  describe "users" do

    test "empty list of active users" do
      users = People.Contract.get_active_users()

      assert length(users) == 0
    end

    test "create a user" do
      {:ok, inserted} = People.Contract.create_user("xyz", "xyz desc")

      assert inserted.user_name == "xyz"
      assert inserted.description == "xyz desc"
      assert inserted.is_active == true
      assert inserted.is_deleted == false
    end

    test "field-level validation prevents user from being created" do
      {:error, message} = People.Contract.create_user(nil, nil)

      assert "User has not been inserted." == message
    end

    test "created user is the same as received" do
      {:ok, inserted} = People.Contract.create_user("xyz", "xyz desc")
      {:ok, retrieved} = People.Contract.get_user("xyz")

      assert inserted.user_name == retrieved.user_name
      assert inserted.description == retrieved.description
      assert inserted.is_active == retrieved.is_active
      assert inserted.is_deleted == retrieved.is_deleted
    end

    test "can't retrieve a user that wasn't created" do
      {:error, message} = People.Contract.get_user("xyz")

      assert "User has not been found." == message
    end

    test "blocked user is ... blocked" do
      {:ok, _} = People.Contract.create_user("xyz", "xyz desc")
      {:ok, blocked} = People.Contract.block_user("xyz")
      {:ok, retrieved} = People.Contract.get_user("xyz")

      assert false == blocked.is_active
      assert false == retrieved.is_active
    end

    test "twice-blocked user is still blocked" do
      {:ok, _} = People.Contract.create_user("xyz", "xyz desc")
      {:ok, _} = People.Contract.block_user("xyz")
      {:ok, twice_blocked} = People.Contract.block_user("xyz")
      {:ok, retrieved} = People.Contract.get_user("xyz")

      assert false == twice_blocked.is_active
      assert false == retrieved.is_active
    end

  end
end
