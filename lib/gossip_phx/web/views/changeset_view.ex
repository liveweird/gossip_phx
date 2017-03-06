defmodule GossipPhx.Web.ChangesetView do
  alias Ecto.Changeset
  use GossipPhx.Web, :view

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `GossipPhx.Web.ErrorHelpers.translate_error/1` for more details.
  """
  @spec translate_errors([]) :: []
  def translate_errors(changeset) do
    Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @spec render(String.t(), %{}) :: %{}
  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: translate_errors(changeset)}
  end
end
