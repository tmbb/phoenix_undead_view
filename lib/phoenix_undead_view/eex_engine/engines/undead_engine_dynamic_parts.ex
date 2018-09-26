defmodule PhoenixUndeadView.EExEngine.Engines.UndeadEngineDynamicParts do
  use PhoenixUndeadView.EExEngine.UndeadEngine
  alias PhoenixUndeadView.EExEngine.{Merger, Utils, Context}

  @doc false
  def handle_body(%Context{} = context) do
    merged = Merger.merge(context.buffer)
    assignments = Utils.variable_assignments(merged, 1, 1)

    dynamic_assignments =
      assignments
      |> Enum.filter(fn {tag, _val} -> tag == :dynamic end)
      |> Enum.map(fn {_tag, val} -> val end)

    {variables, expressions} = Enum.unzip(dynamic_assignments)

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
