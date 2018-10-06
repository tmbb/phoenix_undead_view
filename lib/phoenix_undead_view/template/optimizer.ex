defmodule PhoenixUndeadView.Template.Optimizer do
  # This module doesn't do anything particularly complex.
  # It just applies some simple rules recursively on the nested templates.

  require PhoenixUndeadView.Template.Segment, as: Segment

  def merge_segments([]), do: []

  def merge_segments([s | rest]), do: merge_segments_helper(s, rest)

  def merge_segments_helper(
        Segment.static(bin1, meta1),
        [Segment.static(bin2, meta2) | rest]
      ) do
    merged = Segment.static(bin1 <> bin2, meta1 ++ meta2)
    merge_segments_helper(merged, rest)
  end

  def merge_segments_helper(current, [next | rest]) do
    [current | merge_segments_helper(next, rest)]
  end

  def merge_segments_helper(acc, []) do
    [acc]
  end

  def optimize_inside_undead_container(Segment.undead_container() = segment) do
    Segment.undead_container(optimized_segments) = optimize_expr(segment)

    optimized_segments
    |> List.flatten()
    |> merge_segments()
  end

  def optimize_inside_undead_container(expr) do
    optimize_expr(expr)
  end

  # TODO:
  # Try to replace this recursive implementation with somthing that uses `Macro.prewalk/2`.
  def optimize_expr(Segment.dynamic(Segment.undead_container() = undead_container, _meta)) do
    Segment.segment(optimized_segments, _meta) = optimize_expr(undead_container)

    optimized_segments
  end

  def optimize_expr(Segment.undead_container(segments, meta)) do
    non_optimized_segments =
      for segment <- segments, do: optimize_inside_undead_container(segment)

    optimized_segments =
      non_optimized_segments
      |> List.flatten()
      |> merge_segments()

    Segment.undead_container(optimized_segments, meta)
  end

  def optimize_expr(Segment.support() = segment) do
    segment
  end

  # Segments other than Segment.undead_container()
  def optimize_expr(segment) when Segment.is_segment(segment) do
    Segment.segment(expr, meta) = segment
    Segment.update(segment, optimize_expr(expr), meta)
  end

  def optimize_expr(list) when is_list(list) do
    for expr <- list, do: optimize_expr(expr)
  end

  def optimize_expr({a, b}) do
    {optimize_expr(a), optimize_expr(b)}
  end

  def optimize_expr({f, meta, args}) do
    {f, meta, optimize_expr(args)}
  end

  def optimize_expr(other) do
    other
  end

  def macroexpand_template(template, env) do
    Macro.prewalk(template, &Macro.expand(&1, env))
  end

  def optimize(Segment.undead_container() = template, env) do
    expanded = macroexpand_template(template, env)
    optimize_expr(expanded)
  end

  # # -------------------------------------------------------------
  # # Groups have been commented out because they're not needed yet
  # # -------------------------------------------------------------
  #
  # def segment_to_group(segment) do
  #   group_type = group_type_for(segment)
  #   {group_type, [], [segment]}
  # end
  #
  # defp group_type_for({segment_type, _meta, _contents}) do
  #   case segment_type do
  #     UndeadEngine.Segment.Dynamic -> UndeadEngine.Group.Dynamic
  #     UndeadEngine.Segment.DynamicNoResult -> UndeadEngine.Group.DynamicNoResult
  #     UndeadEngine.Segment.Static -> UndeadEngine.Group.Fixed
  #     UndeadEngine.Segment.Fixed -> UndeadEngine.Group.Fixed
  #   end
  # end

  # def group_adjacent_segments([]), do: []

  # def group_adjacent_segments([s | rest]),
  #   do: group_adjacent_segments_helper(segment_to_group(s), rest)

  # def group_adjacent_segments_helper(
  #       {group_type, meta, segments} = _current_group,
  #       [current_segment | next_segments]
  #     ) do
  #   if group_type_for(current_segment) == group_type do
  #     new_group_segments = [current_segment | segments]
  #     new_current_group = {group_type, meta, new_group_segments}
  #     group_adjacent_segments_helper(new_current_group, next_segments)
  #   else
  #     reversed_group_segments = :lists.reverse(segments)
  #     reversed_current_group = {group_type, meta, reversed_group_segments}
  #     next_group = segment_to_group(current_segment)
  #     [reversed_current_group | group_adjacent_segments_helper(next_group, next_segments)]
  #   end
  # end
end
