defmodule PhoenixUndeadView.EExEngine.Engines.UndeadEngineFull do
  use PhoenixUndeadView.EExEngine.UndeadEngine
  alias PhoenixUndeadView.EExEngine.{Merger, Utils, Context}

  @doc false
  def handle_body(%Context{} = context) do
    merged = Merger.merge(context.buffer)
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

    Macro.expand({:safe, block}, context.env)
  end
end
