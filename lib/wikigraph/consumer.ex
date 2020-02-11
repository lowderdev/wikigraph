defmodule Wikigraph.Consumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [{Wikigraph.ProducerConsumer, max_demand: 1}]}
  end

  def handle_events(events, _from, state) do
    IO.puts("========================")
    IO.inspect(events)
    IO.puts("========================")
    for event <- events do
      IO.inspect({self(), event, state})
    end

    Process.sleep(1000)
    # As a consumer we never emit events
    {:noreply, [], state}
  end
end
