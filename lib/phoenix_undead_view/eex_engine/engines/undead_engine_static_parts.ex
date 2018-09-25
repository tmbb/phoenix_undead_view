defmodule PhoenixUndeadView.EExEngine.Engines.UndeadEngineStaticParts do
  use PhoenixUndeadView.EExEngine.UndeadEngine
  alias PhoenixUndeadView.EExEngine.{Merger, Utils, Context}

  # FIXME:
  # Having to pattern match on the partial AST is very ugly.
  # We must go back and make sure the assignments are emmited ina  more suitable format.
  defp static_value({_tag, {_var, {:=, _meta, [_lhs, binary]}}}), do: binary

  @doc false
  def handle_body(%Context{} = context) do
    merged = Merger.merge(context.buffer)
    assignments = Utils.variable_assignments(merged, 1, 1)

    static_binaries =
      assignments
      |> Enum.filter(fn {tag, _pair} -> tag == :static end)
      |> Enum.map(&static_value/1)

    block =
      quote do
        unquote(static_binaries)
      end

    {:safe, block}
  end
end
