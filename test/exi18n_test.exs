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

  test "translate returns proper translation for given path" do
    assert ExI18n.t("en", "a") == 1
    assert ExI18n.t("en", "b") == "test"
    assert ExI18n.t("en", "c.d") == "test"
    assert ExI18n.t("en", "c.e.f") == "test"
    assert ExI18n.t("en", "g") == ["test1", "test2"]

    assert ExI18n.t("en", "i", nr: 1) == "test1"
    assert ExI18n.t("en", "i", nr: " test") == "test test"
    assert ExI18n.t("en", "i", nr: ["1", "2"]) == "test12"
    assert ExI18n.t("en", "i") == "test%{nr}"
  end

  test "translate raise error for non full path or missing key" do
    assert_raise ArgumentError, "c is incomplete path to translation.", fn ->
      ExI18n.t("en", "c")
    end
    assert_raise ArgumentError, "c.e is incomplete path to translation.", fn ->
      ExI18n.t("en", "c.e")
    end
    assert_raise ArgumentError, "Missing translation for key: h", fn ->
      ExI18n.t("en", "h")
    end
    assert_raise Protocol.UndefinedError, fn ->
      ExI18n.t("en", "i", nr: {"1", "2"}) == "test12"
    end
    assert_raise Protocol.UndefinedError, fn ->
      ExI18n.t("en", "i", nr: %{"1" => "2"}) == "test12"
    end
  end
end
