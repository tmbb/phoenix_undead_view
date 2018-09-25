defmodule PhoenixUndeadView.EExEngine.Engines.UndeadEngineFull do
  use PhoenixUndeadView.EExEngine.UndeadEngineScaffolding
  alias PhoenixUndeadView.EExEngine.{Merger, Utils}

  @doc false
  def handle_body({:toplevel, exprs}) do
    merged = Merger.merge(exprs)
    assignments = Utils.variable_assignments(merged, 1, 1)

    all_assignments = Enum.map(assignments, fn {_tag, pair} -> pair end)
    {variables, expressions} = Enum.unzip(all_assignments)

    block =
      quote do
        # Assign the variables so that scoping rules are respected
        unquote_splicing(expressions)
        # return the list of expressions
        unquote(variables)
      end

    {:safe, block}
  end
end
