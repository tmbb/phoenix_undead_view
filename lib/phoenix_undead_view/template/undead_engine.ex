defmodule PhoenixUndeadView.Template.UndeadEngine do
  @moduledoc false

  # The code was shamelessly stolen from the `phoenix_html` package with only minor modifications.

  # @anno (if :erlang.system_info(:otp_release) >= '19' do
  #          [generated: true]
  #        else
  #          [line: -1]
  #        end)

  use EEx.Engine

  @doc false
  def init(_opts) do
    {UndeadEngine.Segment.UndeadContainer, {[], []}}
  end

  @doc false
  def handle_begin(state) do
    state
  end

  @doc false
  def handle_end({tag, {reversed_segments, meta}}) do
    segments = :lists.reverse(reversed_segments)
    {tag, {segments, meta}}
  end

  @doc false
  def handle_body({tag, {reversed_segments, meta}}) do
    segments = :lists.reverse(reversed_segments)
    {tag, {segments, meta}}
  end

  def handle_text({tag, {reversed_segments, meta}}, text) do
    new_segment = {UndeadEngine.Segment.Static, {text, []}}
    {tag, {[new_segment | reversed_segments], meta}}
  end

  def handle_expr({tag, {reversed_segments, meta}}, "=", expr) do
    line = line_from_expr(expr)
    expr = convert_assigns(expr)

    new_segment = {UndeadEngine.Segment.Dynamic, {expr, [line: line]}}
    new_segments = [new_segment | reversed_segments]

    {tag, {new_segments, meta}}
  end

  def handle_expr({tag, {reversed_segments, meta}}, "/", expr) do
    line = line_from_expr(expr)
    expr = convert_assigns(expr)

    new_segment = {UndeadEngine.Segment.Fixed, {expr, [line: line]}}
    new_segments = [new_segment | reversed_segments]

    {tag, {new_segments, meta}}
  end

  def handle_expr({tag, {reversed_segments, meta}}, "", expr) do
    line = line_from_expr(expr)
    expr = convert_assigns(expr)

    new_segment = {UndeadEngine.Segment.DynamicNoOutput, {expr, [line: line]}}
    new_segments = [new_segment | reversed_segments]

    {tag, {new_segments, meta}}
  end

  defp line_from_expr({_, meta, _}) when is_list(meta), do: Keyword.get(meta, :line)
  defp line_from_expr(_), do: nil

  defp convert_assigns(expr) do
    Macro.prewalk(expr, &handle_assign/1)
  end

  defp handle_assign({:@, meta, [{name, _, atom}]}) when is_atom(name) and is_atom(atom) do
    quote line: meta[:line] || 0 do
      __MODULE__.fetch_assign(var!(assigns), unquote(name))
    end
  end

  defp handle_assign(arg), do: arg

  @doc false
  def fetch_assign(assigns, key) do
    case Access.fetch(assigns, key) do
      {:ok, val} ->
        val

      :error ->
        raise ArgumentError,
          message: """
          assign @#{key} not available in eex template.

          Please make sure all proper assigns have been set. If this
          is a child template, ensure assigns are given explicitly by
          the parent template as they are not automatically forwarded.

          Available assigns: #{inspect(Enum.map(assigns, &elem(&1, 0)))}
          """
    end
  end
end
