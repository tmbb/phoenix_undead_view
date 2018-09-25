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

  def handle_inner_expression(static) when is_binary(static) do
    static
  end

  def handle_inner_expression({:inner, list}) do
    block = inner_variable_assignments(list)
    {:safe, block}
  end

  def handle_inner_expression(expr), do: expr

  def inner_variable_assignments(exprs) do
    assignments =
      for {expr, index} <- Enum.with_index(exprs, 1) do
        var_name = String.to_atom("inner__#{index}")
        var = Macro.var(var_name, __MODULE__)

        processed_expr = handle_inner_expression(expr)

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
