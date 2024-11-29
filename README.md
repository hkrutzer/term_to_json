# TermToJson

Convert many Elixir data types, such as structs and tuples to JSON and back. Useful when you want to serialize data but also make it readable to external tools, such as in a SQL database or log file.

## Installation

Add this to your dependencies in mix.exs.

```elixir
def deps do
  [
    {:term_to_json, "~> 0.1.0"}
  ]
end
```

TermToJson requires Erlang 27 or later.

## Example
```elixir
TermToJson.encode(URI.parse("https://elixir-lang.org/"))
# {":port":443,":scheme":"https",":path":"/",":host":"elixir-lang.org",":__struct__":":Elixir.URI",":userinfo":null,":query":null,":fragment":null,":authority":"elixir-lang.org"}

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
```

## Limitations
- **Don't use this library with untrusted input**
- Not all data types are supported
- When converting from JSON to a struct, whose definition has changed, issues may arise
