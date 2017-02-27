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
      %{"hello" => "world"}
  """
  @spec load(String.t) :: Map.t
  def load(locale) do
    File.cwd!
    |> Path.join(ExI18n.path())
    |> Path.join(locale_file(locale))
    |> read_from_file()
  end

  defp extension, do: ".yml"
  defp locale_file(locale), do: locale <> extension()
end
