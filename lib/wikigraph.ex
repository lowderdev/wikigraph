defmodule Wikigraph do

  # Wikigraph.start("Elixir_(programming_language)")
  def start(uri) do
    response = HTTPoison.get!("https://en.wikipedia.org/wiki/#{uri}")

    # list = """
    #   "<a href=\"/wiki/Metaprogramming\" title=\"Metaprogramming\">metaprogramming</a>",
    #   "<a href=\"/wiki/Macro_(computer_science)\" title=\"Macro (computer science)\">macros</a>",
    #   "<a href=\"/wiki/Polymorphism_(computer_science)\" title=\"Polymorphism (computer science)\">polymorphism</a>",
    #   "<a href=\"#cite_note-4\">&#91;4&#93;</a>",
    #   "<a href=\"/wiki/PagerDuty\" title=\"PagerDuty\">PagerDuty</a>",
    #   "<a href=\"#cite_note-5\">&#91;5&#93;</a>",
    #   "<a rel=\"nofollow\" class=\"external text\" href=\"https://elixir-lang.org\">\"Elixir\"</a>",
    #   "<a href=\"/wiki/Discord_(software)\" title=\"Discord (software)\">Discord</a>",
    #   "<a href=\"#cite_note-6\">&#91;6&#93;</a>",
    #   "<a href=\"#cite_note-7\">&#91;7&#93;</a>"
    # """

    uris = get_valid_uris(response.body)
    %{ parent: uri, children: uris }
  end

  def get_valid_uris(html) do
    Regex.scan(~r{<a[^<]*</a>}, html)
    |> List.flatten()
    |> Enum.filter(&valid_link?/1)
    |> Enum.map(&get_uri/1)
    |> Enum.uniq()
  end

  def valid_link?(string) do
    followable?(string) && wiki_link?(string)
  end

  def followable?(string) do
    !Regex.match?(~r{.*nofollow.*}, string)
  end

  def wiki_link?(string) do
    Regex.match?(~r{.*href=\"/wiki/[^"]*\".*}, string)
  end

  def get_uri(string) do
    [_, href] = Regex.run(~r{.*href=\"/wiki/([^"]*)\".*}, string)
    href
  end
end
