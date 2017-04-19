if Code.ensure_loaded?(YamlElixir) do
  defmodule ExI18n.Loader.YAML do
    @moduledoc """
    Loads translations from YAML files.
    """

    @doc """
    Loads yaml file with translations.

    ## Parameters

      - `locale`: `String` with name of locale/file.
      - `options`: `Map` with options for loader.

    ## Examples

        iex> ExI18n.Loader.YAML.load("en", %{path: "test/fixtures"})
        %{"empty" => "empty", "hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}

        iex> ExI18n.Loader.YAML.load("invalid", %{path: "test/fixtures"})
        ** (ArgumentError) Failed to open file test/fixtures/invalid.yml
    """
    @spec load(String.t, Map.t) :: Map.t
    def load(locale, options \\ %{}) do
      try do
        path = Path.join([File.cwd!, options.path, "#{locale}.yml"])
        YamlElixir.read_from_file(path)
      catch
        {:yamerl_exception, _} ->
          raise(ArgumentError,
                "Failed to open file #{options.path}/#{locale}.yml")
      end
    end
  end
end
