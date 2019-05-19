defmodule People.Service do

  import Ecto.Query

  def create_user(name, description) do
    changeset = People.User.changeset(%People.User{}, %{user_name: name, description: description, is_active: true, is_deleted: false})

    result =
      case Gossip.Repo.insert(changeset) do
        {:ok, %People.User{} = inserted} -> {:ok, inserted}
        _ -> {:error, "User has not been inserted."}
      end

    result
  end

  def get_active_users do
    query =
      from u in People.User,
      where: u.is_active == :true,
      where: u.is_deleted == :false

    query
    |> Gossip.Repo.all
  end

  def get_user(name) do
    query =
      from u in People.User,
      where: u.user_name == ^name,
      where: u.is_deleted == :false

    result =
      case query |> Gossip.Repo.one do
        %People.User{} = retrieved -> {:ok, retrieved}
        nil -> {:error, "User has not been found."}
      end

    result
  end

  def block_user(name) do
    with {:ok, user} <- get_user(name)
    do
      changeset = People.User.changeset(user, %{is_active: false})

      case Gossip.Repo.update(changeset) do
        {:ok, %People.User{} = blocked} -> {:ok, blocked}
        _ -> {:error, "User has not been updated."}
      end
    else
      {:error, _} -> {:error, "User has not been found."}
    end
  end

end
