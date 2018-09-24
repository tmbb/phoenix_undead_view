defmodule PhoenixUndeadView.EExEngine.Utils do
  @moduledoc false

  def variable_assignments([expr | exprs], static_index, dynamic_index) when is_binary(expr) do
    var_name = String.to_atom("static__#{static_index}")
    var = Macro.var(var_name, __MODULE__)

    quoted =
      quote do
        unquote(var) = unquote(expr)
      end

    [{:static, {var, quoted}} | variable_assignments(exprs, static_index + 1, dynamic_index)]
  end

  def variable_assignments([expr | exprs], static_index, dynamic_index) do
    var_name = String.to_atom("dynamic__#{dynamic_index}")
    var = Macro.var(var_name, __MODULE__)

    quoted =
      quote do
        unquote(var) = unquote(expr)
      end

    [{:dynamic, {var, quoted}} | variable_assignments(exprs, static_index, dynamic_index + 1)]
  end

  def variable_assignments([], _static_index, _dynamic_index), do: []
end
