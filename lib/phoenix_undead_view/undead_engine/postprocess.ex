defmodule PhoenixUndeadView.UndeadEngine.Postprocess do
  def compile_full(block), do: block

  def compile_static({:__block__, _meta, exprs} = old_block) do
    last_expr = Enum.at(exprs, -1)
    static = only_static(last_expr)
    {:__block__, _meta, [static]}
  end

  def compile_dynamic({:__block__, _meta, exprs} = old_block) do
    new_exprs = List.update_at(exprs, -1, &only_dynamic/1)
    replace_exprs_in_block(old_block, new_exprs)
  end

  # Private

  defp replace_exprs_in_block({:__block__, meta, _old_exprs} = _old_block, new_exprs) do
    {:__block__, meta, new_exprs}
  end

  defp is_static(bin) when is_binary(bin), do: true

  defp is_static(_expr), do: false

  defp is_dynamic(expr), do: not is_static(expr)

  defp only_static({:safe, list}) when is_list(list) do
    filtered = Enum.filter(list, &is_static/1)
    {:safe, filtered}
  end

  defp only_dynamic({:safe, list}) when is_list(list) do
    filtered = Enum.filter(list, &is_dynamic/1)
    {:safe, filtered}
  end
end