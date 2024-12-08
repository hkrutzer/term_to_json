defmodule TermToJson.Decoder do
  @spec decode(binary()) :: term()
  def decode(json) do
    :json.decode(json, :ok, %{
      null: nil,
      string: fn
        ":" <> x ->
          String.to_atom(x)

        # ISO 8601 datetime pattern
        <<_y::binary-size(4), "-", _m::binary-size(2), "-", _d::binary-size(2), "T",
          _h::binary-size(2), ":", _min::binary-size(2), ":", _s::binary-size(2),
          rest::binary>> = dt
        when rest == "Z" or binary_part(rest, byte_size(rest) - 1, 1) == "Z" ->
          case DateTime.from_iso8601(dt) do
            {:ok, datetime, _offset} -> datetime
            _ -> dt
          end

        # ISO 8601 date pattern
        <<_y::binary-size(4), "-", _m::binary-size(2), "-", _d::binary-size(2)>> = date ->
          case Date.from_iso8601(date) do
            {:ok, date} -> date
            _ -> date
          end

        x ->
          x
      end,
      array_finish: fn acc, old_acc ->
        acc = :lists.reverse(acc)

        case acc do
          ["__tuple__" | rest] ->
            {List.to_tuple(rest), old_acc}

          ["__regex__", source, options] ->
            {Regex.compile!(source, options), old_acc}

          _ ->
            {acc, old_acc}
        end
      end
    })
    |> elem(0)
  end
end
