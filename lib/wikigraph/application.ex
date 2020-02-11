defmodule Wikigraph.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Wikigraph.Producer, [0]),
      worker(Wikigraph.ProducerConsumer, []),
      worker(Wikigraph.Consumer, [])
    ]

    opts = [strategy: :one_for_one, name: Wikigraph.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
