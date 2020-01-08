defmodule UriHelperTest do
  use ExUnit.Case
  doctest UriHelper

  setup_all do
    list = """
      "<a href=\"/wiki/Metaprogramming\" title=\"Metaprogramming\">metaprogramming</a>",
      "<a href=\"/wiki/Macro_(computer_science)\" title=\"Macro (computer science)\">macros</a>",
      "<a href=\"/wiki/Polymorphism_(computer_science)\" title=\"Polymorphism (computer science)\">polymorphism</a>",
      "<a href=\"#cite_note-4\">&#91;4&#93;</a>",
      "<a href=\"/wiki/PagerDuty\" title=\"PagerDuty\">PagerDuty</a>",
      "<a href=\"#cite_note-5\">&#91;5&#93;</a>",
      "<a rel=\"nofollow\" class=\"external text\" href=\"https://elixir-lang.org\">\"Elixir\"</a>",
      "<a href=\"/wiki/Discord_(software)\" title=\"Discord (software)\">Discord</a>",
      "<a href=\"#cite_note-6\">&#91;6&#93;</a>",
      "<a href=\"#cite_note-7\">&#91;7&#93;</a>"
    """

    {:ok, list: list}
  end


  test "get_valid_uris", state do
    expected_uris = ["Metaprogramming", "Macro_(computer_science)", "Polymorphism_(computer_science)", "PagerDuty", "Discord_(software)"]
    assert UriHelper.get_valid_uris(state.list) == expected_uris
  end
end
