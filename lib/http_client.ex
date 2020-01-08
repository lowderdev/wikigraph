defmodule HttpClient do
  @callback get!(binary(), headers(), Keyword.t()) :: HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()
end
