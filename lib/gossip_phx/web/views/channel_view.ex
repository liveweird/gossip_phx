defmodule GossipPhx.Web.ChannelView do
  use GossipPhx.Web, :view

  @spec render(String.t(), %{}) :: %{}
  def render("index.json", %{channels: channels}) do
    %{data: render_many(channels, GossipPhx.Web.ChannelView, "channel.json")}
  end

  @spec render(String.t(), %{}) :: %{}
  def render("show.json", %{channel: channel}) do
    %{data: render_one(channel, GossipPhx.Web.ChannelView, "channel.json")}
  end

  @spec render(String.t(), %{}) :: %{}
  def render("channel.json", %{channel: channel}) do
    %{id: channel.id,
      name: channel.name}
  end
end
