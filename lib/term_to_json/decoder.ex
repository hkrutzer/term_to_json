defmodule TermToJson.Decoder do
  @spec decode(binary()) :: term()
  def decode(json) do
    :json.decode(json, :ok, %{
      null: nil,
      string: fn
        ":" <> x -> String.to_atom(x)
        x -> x
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
