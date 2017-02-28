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

      iex> ExI18n.Loader.YAML.load("en")
      %{"hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}

      iex> ExI18n.Loader.YAML.load("invalid")
      ** (ArgumentError) Failed to open file "/Users/igor/Work/exi18n/test/fixtures/invalid.yml": no such file or directory
  """
  @spec load(String.t) :: Map.t
  def load(locale) do
    try do
      File.cwd!
      |> Path.join(ExI18n.path())
      |> Path.join(locale_file(locale))
      |> read_from_file()
    catch
      {:yamerl_exception, [errors]} ->
        message = elem(errors, 2) |> to_string()
        raise(ArgumentError, message)
    end
  end

  defp extension, do: ".yml"
  defp locale_file(locale), do: locale <> extension()
end
