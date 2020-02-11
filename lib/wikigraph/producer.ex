defmodule Wikigraph.Producer do
  use GenStage

  @initial 0

  def start_link(initial \\ @initial) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(counter), do: {:producer, counter}

  def handle_demand(demand, state) do
    IO.puts("========================")
    IO.puts("produce")
    IO.inspect(demand)
    IO.inspect(state)
    events = Enum.to_list(state..(state + demand - 1))
    {:noreply, events, state + demand}
  end
end
