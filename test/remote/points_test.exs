defmodule Remote.PointsTest do
  use ExUnit.Case, async: true

  alias Remote.Points

  setup do
    {:ok, pid} = Points.start_link([])

    {:ok, pid: pid}
  end

  test "it will get the info of registered name", %{pid: process} do
    assert [registered_name: Remote.Points] == Process.info(process, [:registered_name])
  end

  test "this will get the state of process where timestamps would be nil", %{pid: process} do
    assert %{max_number: _, timestamps: nil} = :sys.get_state(process)
  end

  test "this will do handle_call to process" do
    state = %{max_number: 3, timestamps: nil}
    {:reply, %{timestamps: query_timestamps, users: _users}, new_state} = Points.handle_call(:get_users, nil, state)

    assert %{max_number: 3, timestamps: ^query_timestamps} = new_state
  end
end
