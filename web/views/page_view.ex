defmodule GossipPhx.PageView do
  use GossipPhx.Web, :view

  def render("index.json", %{data: data}) do
    data
  end
end
