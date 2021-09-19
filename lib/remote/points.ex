defmodule Remote.Points do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    schedule_work()

    {:ok, %{max_number: Enum.random(0..100), timestamps: nil}}
  end

  def handle_info(:points, state) do
    Users.update()
    schedule_work()
    {:noreply, %{state | max_number: Enum.random(0..100)}}
  end

  def get_users() do
    GenServer.call(__MODULE__, :get_users)
  end

  def handle_call(:get_users, _from, %{max_number: max_number} = state) do
    datetime = DateTime.truncate(DateTime.utc_now(), :second)

    {:reply, %{users: Users.get_users(max_number), timestamps: datetime},
     %{state | timestamps: datetime}}
  end

  defp schedule_work() do
    Process.send_after(self(), :points, 60 * 1000)
  end
end
