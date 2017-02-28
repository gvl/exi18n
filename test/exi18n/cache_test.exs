defmodule ExI18n.CacheTest do
  use ExUnit.Case
  doctest ExI18n.Cache

  test "fetch/1 returns translations" do
    assert is_map(ExI18n.Cache.fetch("en"))
  end

  test "fetch/1 returns error with message" do
    {:error, msg} = ExI18n.Cache.fetch("invalid")
    assert msg == "Failed to open file test/fixtures/invalid.yml"
  end
end
