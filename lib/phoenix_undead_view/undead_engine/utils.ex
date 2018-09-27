defmodule PhoenixUndeadView.UndeadEngine.Utils do
  @moduledoc false

  alias PhoenixUndeadView.UndeadEngine.Context

  # Currently unused
  def macroexpand(ast, env) do
    Macro.prewalk(ast, fn node -> Macro.expand(node, env) end)
  end

  def variable_assignments([expr | exprs], static_index, dynamic_index) when is_binary(expr) do
    var_name = String.to_atom("static__#{static_index}")
    var = Macro.var(var_name, __MODULE__)

    assignment =
      quote do
        unquote(var) = unquote(expr)
      end

    [{:static, {var, expr, assignment}} | variable_assignments(exprs, static_index + 1, dynamic_index)]
  end

  def variable_assignments([expr | exprs], static_index, dynamic_index) do
    var_name = String.to_atom("dynamic__#{dynamic_index}")
    var = Macro.var(var_name, __MODULE__)

    assignment =
      quote do
        unquote(var) = unquote(expr)
      end

    [{:dynamic, {var, expr, assignment}} | variable_assignments(exprs, static_index, dynamic_index + 1)]
  end

  def variable_assignments([], _static_index, _dynamic_index), do: []

  def handle_inner_expression(static, _level) when is_binary(static) do
    static
  end

  def handle_inner_expression({:inner, list}, level) when is_list(list) do
    block = inner_variable_assignments(list, level)
    {:safe, block}
  end

  def handle_inner_expression(expr, _level) do
    expr
  end

  def inner_variable_assignments(exprs, level) do
    if level == 0 do
      raise "level can't be 0 (zero!)"
    end

    assignments =
      for {expr, index} <- Enum.with_index(exprs, 1) do
        var_name = String.to_atom("inner__#{level}__#{index}")
        var = Macro.var(var_name, __MODULE__)

        processed_expr = handle_inner_expression(expr, level)

        quoted =
          quote do
            unquote(var) = unquote(processed_expr)
          end

        {var, quoted}
      end

    {variables, expressions} = Enum.unzip(assignments)

    block =
      quote do
        # Assign the variables so that scoping rules are respected
        unquote_splicing(expressions)
        # return the list of expressions
        unquote(variables)
      end

    block
  end
end
