defmodule ExI18n.Loader.YAMLTest do
  use ExUnit.Case
  doctest ExI18n.Loader.YAML

  defmodule PathResolver do
    def path(fragment), do: "test/#{fragment}"
  end

  test "load/2 returns loaded translations for locale from yml file" do
    assert {:ok, translations} = ExI18n.Loader.YAML.load("en", %{path: "test/fixtures"})
    assert is_map(translations)

    assert {:ok, translations} =
             ExI18n.Loader.YAML.load("en", %{path: {PathResolver, :path, ["fixtures"]}})

    assert is_map(translations)
  end

  test "load/2 returns error on missing translations file" do
    assert {:error, "Failed to open file test/fixtures/invalid.yml"} ==
             ExI18n.Loader.YAML.load("invalid", %{path: "test/fixtures"})
  end
end
