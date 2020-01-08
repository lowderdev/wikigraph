defmodule UriHelper do
  def get_valid_uris(html) do
    Regex.scan(~r{<a[^<]*</a>}, html)
    |> List.flatten()
    |> Enum.filter(&valid_link?/1)
    |> Enum.map(&get_uri/1)
    |> Enum.uniq()
  end

  defp valid_link?(string) do
    followable?(string) && wiki_link?(string)
  end

  defp followable?(string) do
    !Regex.match?(~r{.*nofollow.*}, string)
  end

  defp wiki_link?(string) do
    Regex.match?(~r{.*href=\"/wiki/[^"]*\".*}, string)
  end

  defp get_uri(string) do
    [_, href] = Regex.run(~r{.*href=\"/wiki/([^"]*)\".*}, string)
    href
  end
end
