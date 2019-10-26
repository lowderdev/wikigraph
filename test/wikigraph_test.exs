defmodule WikigraphTest do
  use ExUnit.Case
  doctest Wikigraph

  test "greets the world" do
    assert Wikigraph.hello() == :world
  end
end
