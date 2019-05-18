defmodule SideEffectsTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = SideEffects.start_link()
    {:ok, side_effects: pid}
  end

  describe "side effects" do

    test "can register a new event type", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :ok == SideEffects.register_event(pid, :something_happened)
    end

    test "can't register a new event type twice", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :ok == SideEffects.register_event(pid, :something_happened)
      assert {:error, _} = SideEffects.register_event(pid, :something_happened)
    end

    test "it's possible to raise event with zero handlers", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :ok == SideEffects.register_event(pid, :something_happened)
      assert :ok == SideEffects.raise_event(pid, :something_happened, "xyz")
    end

    test "registered handled has been called when event of this type was raised", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :ok == SideEffects.register_event(pid, :something_happened)
      handler = fn({self_pid, payload}) ->
        send self_pid, payload
      end
      assert :ok == SideEffects.register_handler(pid, :something_happened, handler)
      assert :ok == SideEffects.raise_event(pid, :something_happened, {self(), "xyz"})
      assert_received "xyz"
    end

    test "registered handled has NOT been called when event of different type was raised", %{side_effects: pid} do
      assert :ok == SideEffects.purge_events(pid)
      assert :ok == SideEffects.register_event(pid, :something_happened)
      assert :ok == SideEffects.register_event(pid, :something_else_happened)
      handler = fn({self_pid, payload}) ->
        send self_pid, payload
      end
      assert :ok == SideEffects.register_handler(pid, :something_happened, handler)
      assert :ok == SideEffects.raise_event(pid, :something_else_happened, {self(), "xyz"})
      refute_receive "xyz", 200
    end

  end
end
