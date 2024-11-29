defmodule TermToJson.MixProject do
  use Mix.Project

  @source_url "https://github.com/hkrutzer/term_to_json"
  @version "0.1.0"

  def project do
    [
      app: :term_to_json,
      version: @version,
      elixir: "~> 1.17",
      deps: deps(),
      docs: docs(),
      package: package(),
      description: "Convert terms to JSON and back"
    ]
  end

  defp docs do
    [
      main: "TermToJson",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.35", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MPL-2.0"],
      maintainers: ["Hans Krutzer"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end
end
