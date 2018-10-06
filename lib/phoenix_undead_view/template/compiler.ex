defmodule PhoenixUndeadView.Template.Compiler do
  require PhoenixUndeadView.Template.Segment, as: Segment
  alias PhoenixUndeadView.Template.Compiler.{PreparedSegment, Escape}

  @cursor_prefix "tmp"

  def example_undead_container() do
    Segment.undead_container([
      Segment.dynamic(quote(do: 1 + 2)),
      Segment.static(" = "),
      Segment.dynamic(quote(do: 4 - 1))
    ])
  end

  defp to_safe(Segment.segment(expr, _meta) = segment) do
    line = Segment.line(segment)
    Escape.to_safe(expr, line)
  end

  def compile_segment(Segment.dynamic() = segment), do: to_safe(segment)

  def compile_segment(Segment.fixed() = segment), do: to_safe(segment)

  def compile_segment(Segment.support(expr, _meta) = _segment), do: expr

  def compile_segment(Segment.static(bin, _meta)), do: bin

  def segments_to_assignments(prepared_segments) do
    for prepared <- prepared_segments,
        prepared.appears_in_body? == true do
      expr = compile_segment(prepared.segment)
      if is_nil(prepared.variable) do
        expr
      else
        quote do
          unquote(prepared.variable) = unquote(expr)
        end
      end
    end
  end

  def segments_to_result(prepared_segments) do
    for prepared <- prepared_segments,
        prepared.appears_in_result? == true do
      if prepared.variable do
        prepared.variable
      else
        compile_segment(prepared.segment)
      end
    end
  end

  def compile_block(prepared_segments) do
    assignments = segments_to_assignments(prepared_segments)
    result = segments_to_result(prepared_segments)

    quote do
      # `assigments` a list of expression, so we must splice them
      unquote_splicing(assignments)
      # `result` is a literal list which we wan to include as the
      # "return" value of the block1
      {:safe, unquote(result)}
    end
  end

  def compile_undead_container(Segment.undead_container(segments, _), cursor) do
    prepared_segments = PreparedSegment.prepare_all_for_full(segments, cursor)
    compile_block(prepared_segments)
  end

  def compile(expanded_ast) do
    {new_ast, _counter} =
      Macro.postwalk(expanded_ast, 1, fn ast_node, counter ->
        case ast_node do
          Segment.undead_container() ->
            cursor = "#{@cursor_prefix}_#{counter}"
            undead_node = compile_undead_container(ast_node, cursor)
            {undead_node, counter + 1}

          other ->
            {other, counter}
        end
      end)

    new_ast
  end

  defp do_compile(Segment.undead_container(segments, _), opts, fun) do
    cursor = Keyword.get(opts, :cursor, @cursor_prefix)

    segments
    |> compile()
    |> fun.(cursor)
    |> compile_block()
  end

  def compile_full(undead_container, opts \\ []) do
    do_compile(undead_container, opts, &PreparedSegment.prepare_all_for_full/2)
  end

  def compile_dynamic(undead_container, opts \\ []) do
    do_compile(undead_container, opts, &PreparedSegment.prepare_all_for_dynamic/2)
  end

  def compile_static(undead_container, opts \\ []) do
    do_compile(undead_container, opts, &PreparedSegment.prepare_all_for_static/2)
  end
end
