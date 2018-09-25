defmodule PhoenixUndeadView.EExEngine.Engines.UndeadEngineStaticPartsUnoptimized do
  use PhoenixUndeadView.EExEngine.UndeadEngineScaffolding
  alias PhoenixUndeadView.EExEngine.{Merger, Utils}

  @doc false
  def handle_body({:toplevel, exprs}) do
    merged = Merger.merge(exprs)
    assignments = Utils.variable_assignments(merged, 1, 1)

    static_assignments =
      assignments
      |> Enum.filter(fn {tag, _pair} -> tag == :static end)
      |> Enum.map(fn {_tag, pair} -> pair end)

    {variables, expressions} = Enum.unzip(static_assignments)

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