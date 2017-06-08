defmodule GossipPhx.Web.ChannelController do
  use GossipPhx.Web, :controller
  use PhoenixSwagger
  require PhoenixSwagger.JsonApi

  alias GossipPhx.Web.Channel

  swagger_path :index do
    get "/api/channels"
    summary "List Gossip channels"
    description "List all available channels"
    paging size: "page[size]", number: "page[number]"
    response 200, "OK", Schema.ref(:Channels)
  end

  swagger_path :create do
    put "/api/channels"
    summary "Create a Gossip channel"
    description "Create a completely new Gossip channel"
    response 200, "OK", Schema.ref(:Channel)
  end

  def swagger_definitions do
    %{
      ChannelResource: JsonApi.resource do
        description "Groups chat around topic"
        attributes do
          id :string, "Unique identifier", required: true
          name :string, "Channel name", required: true
        end
      end,
      Channels: JsonApi.page(:ChannelResource),
      Channel: JsonApi.single(:ChannelResource)
    }
  end

  @spec index(%{}, []) :: any()
  def index(conn, _params) do
    channels = Repo.all(Channel)
    render(conn, "index.json", channels: channels)
  end

  @spec create(%{}, %{}) :: any()
  def create(conn, %{"channel" => channel_params}) do
    changeset = Channel.changeset(%Channel{}, channel_params)

    case Repo.insert(changeset) do
      {:ok, channel} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", channel_path(conn, :show, channel))
        |> render("show.json", channel: channel)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GossipPhx.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  @spec show(%{}, %{}) :: any()
  def show(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)
    render(conn, "show.json", channel: channel)
  end

  @spec update(%{}, %{}) :: any()
  def update(conn, %{"id" => id, "channel" => channel_params}) do
    channel = Repo.get!(Channel, id)
    changeset = Channel.changeset(channel, channel_params)

    case Repo.update(changeset) do
      {:ok, channel} ->
        render(conn, "show.json", channel: channel)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GossipPhx.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  @spec delete(%{}, %{}) :: any()
  def delete(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(channel)

    send_resp(conn, :no_content, "")
  end
end
