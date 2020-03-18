if Code.ensure_loaded?(YamlElixir) do
  defmodule ExI18n.Loader.YAML do
    @moduledoc """
    Loads translations from YAML files.
    """
    @behaviour ExI18n.Loader

    @doc """
    Loads yaml file with translations.

    ## Parameters

      - `locale`: `String` with name of locale/file.
      - `options`: `Map` with options for loader.

    ## Examples

        iex> ExI18n.Loader.YAML.load("en", %{path: "test/fixtures"})
        {:ok, %{"empty" => "empty", "hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}}

        iex> ExI18n.Loader.YAML.load("invalid", %{path: "test/fixtures"})
        {:error, "Failed to open file test/fixtures/invalid.yml"}
    """
    @impl true
    def load(locale, options \\ %{}) do
      with path <- Path.join([resolve_path(options.path), "#{locale}.yml"]),
           {:ok, translations} <- YamlElixir.read_from_file(path) do
        {:ok, translations}
      else
        {:error, _} -> {:error, "Failed to open file #{options.path}/#{locale}.yml"}
      end
    end

    defp resolve_path(path) when is_bitstring(path), do: path
    defp resolve_path({m, f, a}), do: apply(m, f, a)
  end
end
