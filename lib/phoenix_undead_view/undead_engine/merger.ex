defmodule PhoenixUndeadView.UndeadEngine.Merger do
  @moduledoc false

  defguard is_static(expr) when is_binary(expr)

  defguard is_dynamic(expr) when not is_binary(expr)

  @doc """
  Optimize binaries in an expression.

  Merges adjacent binaries and drops the empty binary (`""`)
  """
  def optimize_binaries(exprs) do
    optimize_static_helper("", exprs)
  end

  defp optimize_static_helper("", []), do: []

  defp optimize_static_helper(acc, []), do: [acc]

  defp optimize_static_helper("", [expr | exprs]), do: optimize_static_helper(expr, exprs)

  defp optimize_static_helper(acc, [expr | exprs]) when is_static(acc) and is_static(expr) do
    optimize_static_helper(acc <> expr, exprs)
  end

  defp optimize_static_helper(acc, [expr | exprs]) do
    [acc | optimize_static_helper(expr, exprs)]
  end

  @doc """
  Merge adjacent static and dynamic parts of the template.

  The resulting list will ALWAYS start with a binary and end with a binary
  (both of which can be the empty binary - `""`).
  """
  def merge(exprs) do
    merge_helper("", exprs)
  end

  defp merge_helper(acc, [expr | exprs]) when is_static(acc) and is_binary(expr) do
    merge_helper(acc <> expr, exprs)
  end

  defp merge_helper(acc, [expr | exprs]) when is_static(acc) and is_dynamic(expr) do
    [acc | merge_helper(expr, exprs)]
  end

  defp merge_helper(acc, [expr | exprs]) when is_dynamic(acc) and is_binary(expr) do
    [block_from_acc(acc) | merge_helper(expr, exprs)]
  end

  defp merge_helper(acc, [expr | exprs]) when is_dynamic(acc) and is_dynamic(expr) do
    merge_helper(acc ++ [expr], exprs)
  end

  defp merge_helper(acc, []) when is_static(acc) do
    [acc]
  end

  defp merge_helper(acc, []) when is_dynamic(acc) do
    [block_from_acc(acc), ""]
  end

  defp block_from_acc(acc) do
    exprs = List.wrap(acc)

    block =
      quote do
        (unquote_splicing(exprs))
      end

    block
  end
end
