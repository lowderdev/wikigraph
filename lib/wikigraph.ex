defmodule Wikigraph do
  use GenServer
  import UriHelper

  def start_link(uri) do
    GenServer.start_link(__MODULE__, uri)
  end

  # Wikigraph.init("Elixir_(programming_language)")
  def init(uri) do
    payload = uri
      |> scrape()
      |> publish(uri)
    {:ok, Enum.count(payload.children)}
  end

  # Wikigraph.scrape("Elixir_(programming_language)")
  def scrape(uri) do
    response = HTTPoison.get!("https://en.wikipedia.org/wiki/#{uri}")
    get_valid_uris(response.body)
  end

  def publish(children, parent) do
    %{ children: children, parent: parent }
    |> IO.inspect()
  end
end
