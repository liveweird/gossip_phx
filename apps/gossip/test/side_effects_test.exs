defmodule SideEffectsTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = SideEffects.start_link()
    {:ok, side_effects: pid}
  end

  describe "side effects" do

    test "can register a new event type", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :something_happened == SideEffects.register_event(pid, :something_happened)
    end

    test "can't register a new event type twice", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :something_happened == SideEffects.register_event(pid, :something_happened)
      assert {:error, _} = SideEffects.register_event(pid, :something_happened)
    end

  end
end
