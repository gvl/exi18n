defmodule ExI18nTest do
  use ExUnit.Case
  doctest ExI18n

  test "locale" do
    assert ExI18n.locale() == "en"
  end

  test "path" do
    assert ExI18n.path() == "test/fixtures"
  end

  test "storage" do
    assert ExI18n.storage() == :yml
  end
end
