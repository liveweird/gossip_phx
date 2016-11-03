defmodule GossipPhx.WhisperTest do
  use GossipPhx.ModelCase

  alias GossipPhx.Whisper

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Whisper.changeset(%Whisper{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Whisper.changeset(%Whisper{}, @invalid_attrs)
    refute changeset.valid?
  end
end
