defmodule ExI18n.Storage.YAML do
  import YamlElixir

  def load(locale) do
    File.cwd!
    |> Path.join(ExI18n.path())
    |> Path.join(locale_file(locale))
    |> read_from_file()
  end

  defp extension, do: ".yml"
  defp locale_file(locale), do: locale <> extension()
end
