defmodule GossipPhx.Web.PageView do
  use GossipPhx.Web, :view

  @spec render(String.t(), %{}) :: any()
  def render("index.json", %{data: data}) do
    data
  end
end
