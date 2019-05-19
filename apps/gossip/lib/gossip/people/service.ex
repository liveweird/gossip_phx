defmodule People.Service do

  import Ecto.Query

  def create_user(user_name, user_description) do
    changeset = People.User.changeset(%People.User{}, %{name: user_name, description: user_description, is_active: true, is_deleted: false})

    result =
      case Gossip.Repo.insert(changeset) do
        {:ok, %People.User{} = inserted} -> {:ok, inserted}
        _ -> {:error, "User has not been created."}
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

  def get_user(user_name) do
    query =
      from u in People.User,
      where: u.name == ^user_name,
      where: u.is_deleted == :false

    result =
      case query |> Gossip.Repo.one do
        %People.User{} = retrieved -> {:ok, retrieved}
        nil -> {:error, "User has not been found."}
      end

    result
  end

  def block_user(user_name) do
    with {:ok, user} <- get_user(user_name)
    do
      changeset = People.User.changeset(user, %{is_active: false})

      case Gossip.Repo.update(changeset) do
        {:ok, %People.User{} = blocked} -> {:ok, blocked}
        _ -> {:error, "User has not been blocked."}
      end
    else
      {:error, _} -> {:error, "User has not been found."}
    end
  end

end
