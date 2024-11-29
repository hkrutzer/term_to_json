defmodule TermToJsonTest do
  use ExUnit.Case
  doctest TermToJson

  test "encoding" do
    assert TermToJson.encode(%{}) == "{}"
    assert TermToJson.encode(%{1 => 2}) == ~s({"1":2})
    assert TermToJson.encode(%{3.1 => 4}) == ~s({"3.1":4})
    assert TermToJson.encode("hello\0world\t✂️") == ~s("hello\\u0000world\\t✂️")
  end

  test "encoding / decoding" do
    test_data = [
      "a",
      123,
      :atom,
      nil,
      true,
      [1, 2, 3],
      %{},
      {:ok, "ok"},
      {:error, %{reason: "error"}},
      URI.parse("https://elixir-lang.org/"),
      ~r/c(?<foo>d)/,
      ~r/^[[:alnum:][:blank:]]+$/,
      ~r/foo/uiU,
      MapSet.new(["a", "b"]),
      {%{nested: ["data"]}}
    ]

    for data <- test_data do
      assert TermToJson.decode(TermToJson.encode(data)) == data
    end
  end

  test "encoding to iolist" do
    assert TermToJson.encode(%{foo: :bar}, as: :iolist) == [123, "\":foo\":\":bar\"", 125]
  end
end
