defmodule ExI18n.LoaderTest do
  use ExUnit.Case
  doctest ExI18n.Loader

  test "get/1 returns loader module based on type" do
    assert ExI18n.Loader.get(:yml) == ExI18n.Loader.YAML
  end

  test "load/1 returns loaded translations for locale" do
    assert is_map(ExI18n.Loader.load("en"))
  end
end
