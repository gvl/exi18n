defmodule ExI18n.CacheTest do
  use ExUnit.Case
  doctest ExI18n.Cache

  test "fetch/1 returns translations" do
    assert is_map(ExI18n.Cache.fetch("en"))
  end

  test "fetch/1 returns error with message" do
    {:error, msg} = ExI18n.Cache.fetch("invalid")
    assert msg == "Failed to open file " <>
                  "\"/Users/igor/Work/exi18n/test/fixtures/invalid.yml\":" <>
                  " no such file or directory"
  end
end
