defmodule ExI18n.Compiler do
  @moduledoc """
  Compile text with provided values.
  """

  @prefix Application.get_env(:exi18n, :var_prefix) || "%{"
  @suffix Application.get_env(:exi18n, :var_suffix) || "}"

  @doc """
  Compile text with provided values.

  ## Parameters

    - `text`: `String` or `List` of strings to compile.
    - `values`: `Map` of values.

  ## Examples

      iex> ExI18n.Compiler.compile("hello %{test}", %{"test" => "world"})
      "hello world"

      iex> ExI18n.Compiler.compile("hello %{test}", %{})
      "hello %{test}"

      iex> ExI18n.Compiler.compile(["hello %{test}", "No.%{nr}"], %{"test" => "world", "nr" => 1})
      ["hello world", "No.1"]
  """
  @spec compile(String.t() | List.t(), map()) :: String.t()
  def compile(text, values) when is_bitstring(text) do
    Enum.reduce(values, text, fn {key, value}, result ->
      String.replace(result, variable(key), to_string(value))
    end)
  end

  def compile(texts, values) when is_list(texts) do
    Enum.map(texts, fn text -> compile(text, values) end)
  end

  defp variable(key) do
    "#{@prefix}#{key}#{@suffix}"
  end
end
