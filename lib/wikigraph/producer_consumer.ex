defmodule Wikigraph.ProducerConsumer do
  use GenStage

  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [{Wikigraph.Producer, max_demand: 1}]}
  end

  def handle_events(events, _from, state) do
    numbers =
      events
      |> Enum.filter(&Integer.is_even/1)

    # IO.puts("========================")
    # IO.puts("producer-consumer")
    # IO.inspect(events)
    # IO.inspect(numbers)
    {:noreply, numbers, state}
  end
end
