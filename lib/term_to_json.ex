defmodule TermToJson do
  @moduledoc """
  Convert Elixir terms to and from JSON strings.
  """

  @doc """
  Encode an Elixir term to a JSON string.

  ## Examples

      iex> TermToJson.encode(1)
      "1"
  """
  defdelegate encode(term, opts \\ []), to: TermToJson.Encoder

  @doc """
  Decode a JSON string to an Elixir term.

  ## Examples

      iex> TermToJson.decode(~s({":major": 1,":minor": 3,":build": null,":__struct__": ":Elixir.Version",":pre": [],":patch": 7}))
      %Version{major: 1, minor: 3, patch: 7}
  """
  defdelegate decode(string), to: TermToJson.Decoder
end
