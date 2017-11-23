defmodule ExI18nTest do
  use ExUnit.Case
  doctest ExI18n

  test "locale/0" do
    assert ExI18n.locale() == "en"
  end

  test "fallback/0" do
    Application.put_env(:exi18n, :fallback, true)

    assert ExI18n.fallback() == true
  end

  test "t/3 returns proper translation for given path" do
    assert ExI18n.t("en", "number") == 1
    assert ExI18n.t("en", "hello") == "Hello world"
    assert ExI18n.t("en", "hello_2.world") == "test"
    assert ExI18n.t("en", "incomplete.path.text") == "test"
    assert ExI18n.t("en", "hello_many") == ["Joe", "Mike"]

    assert ExI18n.t("en", "hello_name", name: "Joe") == "Hello Joe"
    assert ExI18n.t("en", "hello_name") == "Hello %{name}"
  end

  test "t/3 raise error for invalid key" do
    assert_raise ArgumentError, "Invalid key - must be string", fn ->
      ExI18n.t("en", nil)
    end

    assert_raise ArgumentError, "Invalid key - must be string", fn ->
      ExI18n.t("en", %{a: 1})
    end

    assert_raise ArgumentError, "Invalid key - must be string", fn ->
      ExI18n.t("en", [])
    end
  end

  test "t/3 raise error for invalid values" do
    assert_raise ArgumentError, "Values for translation need to be a map or keyword list", fn ->
      ExI18n.t("en", "hello_name", [1])
    end

    assert_raise ArgumentError, "Values for translation need to be a map or keyword list", fn ->
      ExI18n.t("en", "hello_name", "test")
    end

    assert_raise ArgumentError, "Only string, boolean or number allowed for values.", fn ->
      ExI18n.t("en", "hello_name", name: {"1", "2"})
    end

    assert_raise ArgumentError, "Only string, boolean or number allowed for values.", fn ->
      ExI18n.t("en", "hello_name", name: %{test: "1"})
    end

    assert_raise ArgumentError, "Only string, boolean or number allowed for values.", fn ->
      ExI18n.t("en", "hello_name", name: [1, 2, 3])
    end
  end

  test "t/3 raise error for incomplete path or missing key" do
    assert_raise ArgumentError, "incomplete is incomplete path to translation.", fn ->
      ExI18n.t("en", "incomplete")
    end

    assert_raise ArgumentError, "incomplete.path is incomplete path to translation.", fn ->
      ExI18n.t("en", "incomplete.path")
    end

    assert_raise ArgumentError, "Missing translation for key: invalid", fn ->
      ExI18n.t("en", "invalid")
    end

    assert_raise ArgumentError, "Missing translation for key: ", fn ->
      ExI18n.t("en", "")
    end
  end

  test "t/3 fallback to default locale if passed unsupported locale" do
    assert ExI18n.t("fr", "hello") == "Hello world"
  end

  test "t/3 fallback to default locale translation if translation empty" do
    Application.put_env(:exi18n, :locales, ~w(en de))
    Application.put_env(:exi18n, :fallback, true)

    assert ExI18n.t("de", "empty") == ExI18n.t("en", "empty")

    assert_raise ArgumentError, "Missing translation for key: empty2", fn ->
      ExI18n.t("de", "empty2")
    end

    Application.put_env(:exi18n, :fallback, false)

    assert ExI18n.t("de", "empty") != ExI18n.t("en", "empty")
  end
end
