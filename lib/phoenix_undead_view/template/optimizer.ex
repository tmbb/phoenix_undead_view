defmodule PhoenixUndeadView.Template.Optimizer do
  def merge_segments([]), do: []

  def merge_segments([s | rest]), do: merge_segments_helper(s, rest)

  def merge_segments_helper(
        {UndeadEngine.Segment.Static, {bin1, meta1}},
        [{UndeadEngine.Segment.Static, {bin2, meta2}} | rest]
      ) do
    merged = {UndeadEngine.Segment.Static, {bin1 <> bin2, meta1 ++ meta2}}
    merge_segments_helper(merged, rest)
  end

  def merge_segments_helper(current, [next | rest]) do
    [current | merge_segments_helper(next, rest)]
  end

  def merge_segments_helper(acc, []) do
    [acc]
  end

  def optimize_inside_undead_template(
        {UndeadEngine.Segment.UndeadTemplate, {_segments, _meta}} = segment
      ) do
    {UndeadEngine.Segment.UndeadTemplate, {optimized_segments, _meta}} = optimize_expr(segment)

    optimized_segments
    |> List.flatten()
    |> merge_segments()
  end

  def optimize_inside_undead_template(expr) do
    optimize_expr(expr)
  end

  def optimize_expr(
        {outer_tag, {{inner_tag, {_segments, _inner_meta}} = undead_template, _outer_meta}}
      )
      when outer_tag == UndeadEngine.Segment.Dynamic and
             inner_tag == UndeadEngine.Segment.UndeadTemplate do
    {_tag, {optimized_segments, _meta}} = optimize_expr(undead_template)

    optimized_segments
  end

  def optimize_expr({UndeadEngine.Segment.UndeadTemplate = tag, {segments, meta}}) do
    non_optimized_segments = for segment <- segments, do: optimize_inside_undead_template(segment)

    optimized_segments =
      non_optimized_segments
      |> List.flatten()
      |> merge_segments()

    {tag, {optimized_segments, meta}}
  end

  def optimize_expr({tag, {expr, meta}})
      when tag in [
             UndeadEngine.Segment.Dynamic,
             UndeadEngine.Segment.DynamicNoOutput,
             UndeadEngine.Segment.Fixed,
             UndeadEngine.Segment.Static
           ] do
    {tag, {optimize_expr(expr), meta}}
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

  def optimize({UndeadEngine.Segment.UndeadTemplate, {_, _}} = template, env) do
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
