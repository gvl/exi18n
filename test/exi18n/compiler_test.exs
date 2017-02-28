defmodule ExI18n.CompilerTest do
  use ExUnit.Case
  doctest ExI18n.Compiler

  test "compile/2 returns compiled text" do
    text = "hello %{test}"
    values = %{"test" => "world"}

    assert ExI18n.Compiler.compile("", %{}) == ""
    assert ExI18n.Compiler.compile(text, values) == "hello world"
    assert ExI18n.Compiler.compile(text, %{}) == "hello %{test}"
    assert ExI18n.Compiler.compile([text, "%{test}"], values) == ["hello world", "world"]
  end
end
