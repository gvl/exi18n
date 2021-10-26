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
       build_locale_file(locale, resolve_path(options.path)) |> YamlElixir.read_from_string
    end

    def build_locale_file(locale, path) do
      file_path = [path, "#{locale}.yml"] |> Path.join
      folder_path = [path, locale] |> Path.join
      if file_path |> File.exists? do
        file_path |> File.read!
      else
        file_paths = [path, locale, "*.yml"] |> Path.join |> Path.wildcard
        Enum.map(file_paths, fn file_path -> 
          file_path |> File.read!
        end) |> Enum.join("\n")
      end
    end

    defp resolve_path(path) when is_bitstring(path), do: path
    defp resolve_path({m, f, a}), do: apply(m, f, a)
  end
end
