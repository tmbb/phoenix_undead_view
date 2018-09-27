defmodule PhoenixUndeadView.UndeadEngine do
  @moduledoc false

  # The code was shamelessly stolen from the `phoenix_html` package with only minor modifications.

  @anno (if :erlang.system_info(:otp_release) >= '19' do
            [generated: true]
          else
            [line: -1]
          end)

  use EEx.Engine

  alias PhoenixUndeadView.UndeadEngine.{Merger, Utils, Context}

  @doc false
  def init(opts) do
    options = Keyword.get(opts, :opts, [])
    env = Keyword.get(options, :env)
    Context.new_toplevel(env: env)
  end

  @doc false
  def handle_begin(%Context{} = context) do
    Context.move_to_next_level(context)
  end

  @doc false
  # If possible, optimize the binaries in the list.
  # It produced cleaner results and might be a little faster at runtime.
  def handle_end(%Context{level: level} = context) when level > 0 do
    %{buffer: exprs} = Context.reverse_buffer(context)
    new_exprs =
      exprs
      |> Merger.optimize_binaries()
      |> Utils.inner_variable_assignments(level)

    new_exprs
  end

  def handle_end(%Context{level: 0} = context), do: Context.reverse_buffer(context)

  @doc false
  def handle_body(%Context{} = context) do
    %{buffer: buffer} = Context.reverse_buffer(context)
    merged = Merger.merge(buffer)
    assignments = Utils.variable_assignments(merged, 1, 1)

    dynamic_expressions =
      assignments
      |> Enum.filter(&is_dynamic/1)
      |> Enum.map(&expression/1)

    result = Enum.map(assignments, &variable_or_value/1)

    block =
      quote do
        # Assign the variables so that scoping rules are respected
        unquote_splicing(dynamic_expressions)
        # return the list of expressions
        {:safe, unquote(result)}
      end

    block
  end

  def handle_text(%Context{} = context, text) do
    Context.prepend_to_buffer(context, text)
  end

  def handle_expr(%Context{} = context, "=", expr) do
    line = line_from_expr(expr)
    expr = expr(expr)

    Context.prepend_to_buffer(context, to_safe(expr, line))
  end

  def handle_expr(%Context{} = context, "", expr) do
    expr = expr(expr)

    block =
      quote do
        unquote(expr)
        ""
      end

    Context.prepend_to_buffer(context, block)
  end

  defp line_from_expr({_, meta, _}) when is_list(meta), do: Keyword.get(meta, :line)
  defp line_from_expr(_), do: nil

  # We can do the work at compile time
  defp to_safe(literal, _line)
        when is_binary(literal) or is_atom(literal) or is_number(literal) do
    Phoenix.HTML.Safe.to_iodata(literal)
  end

  # We can do the work at runtime
  defp to_safe(literal, line) when is_list(literal) do
    quote line: line, do: Phoenix.HTML.Safe.to_iodata(unquote(literal))
  end

  # We need to check at runtime and we do so by
  # optimizing common cases.
  defp to_safe(expr, line) do
    # Keep stacktraces for protocol dispatch...
    fallback = quote line: line, do: Phoenix.HTML.Safe.to_iodata(other)

    # However ignore them for the generated clauses to avoid warnings
    quote @anno do
      case unquote(expr) do
        {:safe, data} -> data
        bin when is_binary(bin) -> Plug.HTML.html_escape_to_iodata(bin)
        other -> unquote(fallback)
      end
    end
  end

  defp expr(expr) do
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

  defp is_dynamic({:dynamic, _}), do: true

  defp is_dynamic(_), do: false

  defp expression({tag, {_var, _val, quoted}}) when tag in [:static, :dynamic] do
    quoted
  end

  defp variable_or_value({:dynamic, {var, _val, _quoted}}), do: var

  defp variable_or_value({:static, {_var, binary, _quoted}}), do: binary
end
