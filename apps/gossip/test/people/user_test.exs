defmodule People.UserTest do
  use Gossip.DataCase

  describe "users" do

    test "empty list of active users" do
      users = People.Contract.get_active_users()

      assert length(users) == 0
    end

    test "create a user" do
      inserted = People.Contract.create_user("xyz", "xyz desc")

      assert inserted.user_name == "xyz"
      assert inserted.description == "xyz desc"
      assert inserted.is_active == true
      assert inserted.is_deleted == false
    end

    test "field-level validation prevents user from being created" do
      inserted = People.Contract.create_user(nil, nil)

      assert nil == inserted
    end
  end
end
