defmodule PhoenixUndeadView.EExEngine.UndeadEngineImpl do
  @moduledoc false

  # The code was shamelessly stolen from the `phoenix_html` package with only minor modifications.

  @anno (if :erlang.system_info(:otp_release) >= '19' do
            [generated: true]
          else
            [line: -1]
          end)

  use EEx.Engine

  alias PhoenixUndeadView.EExEngine.{Merger, Utils, Context}

  @doc false
  def init(opts) do
    options = Keyword.get(opts, :opts, [])
    env = Keyword.get(options, :env)
    Context.new_toplevel(env: env)
  end

  @doc false
  def handle_begin(%Context{} = context) do
    Context.new_inner(env: context.env)
  end

  @doc false
  # If possible, optimize the binaries in the list.
  # It produced cleaner results and might be a little faster at runtime.
  def handle_end(%Context{buffer: exprs, type: :inner} = _context) do
    new_exprs =
      exprs
      |> Merger.optimize_binaries()
      |> Utils.inner_variable_assignments()

    new_exprs
  end

  def handle_end(%Context{type: :toplevel} = context), do: context

  def handle_text(%Context{} = context, text) do
    Context.append_to_buffer(context, text)
  end

  def handle_expr(%Context{} = context, "=", expr) do
    line = line_from_expr(expr)
    expr = expr(expr)
    Context.append_to_buffer(context, to_safe(expr, line))
  end

  def handle_expr(%Context{} = context, "", expr) do
    expr = expr(expr)

    block =
      quote do
        unquote(expr)
        ""
      end

    Context.append_to_buffer(context, block)
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
end
