defmodule GossipPhx.Web.ChannelView do
  use GossipPhx.Web, :view

  def render("index.json", %{channels: channels}) do
    %{data: render_many(channels, GossipPhx.Web.ChannelView, "channel.json")}
  end

  def render("show.json", %{channel: channel}) do
    %{data: render_one(channel, GossipPhx.Web.ChannelView, "channel.json")}
  end

  def render("channel.json", %{channel: channel}) do
    %{id: channel.id,
      name: channel.name}
  end
end
