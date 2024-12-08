# TermToJson

[![Documentation badge](https://img.shields.io/badge/Hexdocs-ff6900)](https://hexdocs.pm/term_to_json/)
[![Hex.pm badge](https://img.shields.io/badge/hex.pm-informational)](https://hex.pm/packages/term_to_json)

Convert many Elixir data types, such as structs and tuples to JSON and back. Useful when you want to serialize data but also make it readable or queryable to external tools, such as in a SQL database or log file.

## Installation

Add this to your dependencies in mix.exs.

```elixir
def deps do
  [
    {:term_to_json, "~> 0.1.1"}
  ]
end
```

TermToJson requires Elixir 1.17 and Erlang 27 or later.

## Example
```elixir
TermToJson.encode(URI.parse("https://elixir-lang.org/"))
# => {":port":443,":scheme":"https",":path":"/",":host":"elixir-lang.org",":__struct__":":Elixir.URI",":userinfo":null,":query":null,":fragment":null,":authority":"elixir-lang.org"}

TermToJson.decode(~s({":port":443,":scheme":"https",":path":"/",":host":"elixir-lang.org",":__struct__":":Elixir.URI",":userinfo":null,":query":null,":fragment":null,":authority":"elixir-lang.org"}))
# %URI{
#   scheme: "https",
#   authority: "elixir-lang.org",
#   userinfo: nil,
#   host: "elixir-lang.org",
#   port: 443,
#   path: "/",
#   query: nil,
#   fragment: nil
# }

TermToJson.encode({:ok, ~U[2022-01-11 12:00:12Z]})
# => ["__tuple__",":ok","2022-01-11T12:00:12Z"]

TermToJson.decode("[\"__tuple__\",\":error\",\":http_timeout\"]")
# => {:error, :http_timeout}

1..10 |> TermToJson.encode() |> TermToJson.decode()
# => 1..10
```

## Limitations
- **Don't use this library with untrusted input**
- Not all data types are supported
- When converting from JSON to a struct, whose definition has changed, issues may arise

### Alternatives
- `:erlang.term_to_binary/1` and `:erlang.binary_to_term/1`
- [`Plug.Crypto.non_executable_binary_to_term`](https://hexdocs.pm/plug_crypto/Plug.Crypto.html#non_executable_binary_to_term/2)
- [`Jason`](https://hex.pm/packages/jason)
- [:json](https://www.erlang.org/doc/apps/stdlib/json.html)
