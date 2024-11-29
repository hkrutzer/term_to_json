defmodule TermToJson.Encoder do
  @spec encode(term(), keyword()) :: iolist() | binary()
  def encode(test_data, opts \\ []) do
    encoded =
      :json.encode(test_data, fn
        tuple, encoder when is_tuple(tuple) ->
          encoder.(["__tuple__" | Tuple.to_list(tuple)], encoder)

        nil, _encoder ->
          "null"

        %Regex{} = regex, encoder ->
          ["__regex__", Regex.source(regex), Regex.opts(regex)] |> encoder.(encoder)

        map, encoder when is_map(map) ->
          r =
            map
            |> Map.to_list()
            # TODO improve efficiency
            |> Enum.map(fn
              {k, v} -> [key(k, encoder), ?:, encoder.(v, encoder)]
            end)
            |> Enum.join(",")

          [?{, r, ?}]

        term, encoder when is_atom(term) ->
          :json.encode_value(":" <> to_string(term), encoder)

        term, encoder ->
          :json.encode_value(term, encoder)
      end)

    case Keyword.get(opts, :as, :string) do
      :iolist ->
        encoded

      :string ->
        :erlang.iolist_to_binary(encoded)
    end
  end

  defp key(key, encode) when is_binary(key) or is_atom(key) do
    encode.(key, encode)
  end

  defp key(key, _encode) when is_integer(key) do
    [?", :json.encode_integer(key), ?"]
  end

  defp key(key, _encode) when is_float(key) do
    [?", :json.encode_float(key), ?"]
  end
end
