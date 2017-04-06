if Code.ensure_loaded?(YamlElixir) do
  defmodule ExI18n.Loader.YAML do
    @moduledoc """
    Loads translations from YAML files.
    """
    import YamlElixir

    @doc """
    Loads yaml file with translations.

    ## Parameters

      - `locale`: `String` with name of locale/file.

    ## Examples

        iex> ExI18n.Loader.YAML.load("en", %{path: "test/fixtures"})
        %{"empty" => "empty", "hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}

        iex> ExI18n.Loader.YAML.load("invalid", %{path: "test/fixtures"})
        ** (ArgumentError) Failed to open file test/fixtures/invalid.yml
    """
    @spec load(String.t, Map.t) :: Map.t
    def load(locale, options \\ %{}) do
      try do
        File.cwd!
        |> Path.join(options.path)
        |> Path.join(locale_file(locale))
        |> read_from_file()
      catch
        {:yamerl_exception, _} ->
          raise(ArgumentError,
                "Failed to open file #{options.path}/#{locale_file(locale)}")
      end
    end

    defp locale_file(locale), do: "#{locale}.yml"
  end
end