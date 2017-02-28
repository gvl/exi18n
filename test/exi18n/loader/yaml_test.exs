defmodule ExI18n.Loader.YAMLTest do
  use ExUnit.Case
  doctest ExI18n.Loader.YAML

  test "load/1 returns loaded translations for locale from yml file" do
    assert is_map(ExI18n.Loader.YAML.load("en"))
  end

  test "load/1 returns error on missing translations file" do
    assert_raise ArgumentError, fn ->
      ExI18n.Loader.YAML.load("invalid")
    end
  end
end
