defmodule PhoenixUndeadView.EExEngine.UndeadEngineScaffolding do
  @moduledoc false

  # This macro defines the functions that are common to all the engines.
  # Only the final processing done on the body of the template is specific to each template.
  # It's bad style to write this much code in a `__using__` macro, so I should refactor it
  # one of these days to only import functions from another module.
  #
  # The code was shamelessly stolen from the `phoenix_html` package with only minor modifications.
  defmacro __using__(_opts \\ []) do
    quote do
      @anno (if :erlang.system_info(:otp_release) >= '19' do
               [generated: true]
             else
               [line: -1]
             end)

      use EEx.Engine

      alias PhoenixUndeadView.EExEngine.Merger

      @doc false
      def init(_opts), do: {:safe, [""]}

      @doc false
      def handle_begin(_previous), do: {:safe, [""]}

      @doc false
      # If possible, optimize the binaries in the list.
      # It produced cleaner results and might be a little faster at runtime.
      def handle_end({:safe, list}) do
        Merger.optimize_binaries(list)
      end

      def handle_end(quoted), do: quoted

      @doc false
      # Required for Elixir < v1.5.1
      def handle_text("", text) do
        handle_text({:safe, ""}, text)
      end

      def handle_text({:safe, buffer}, text) do
        quote do
          # FIXME:
          # Appending to the end of the list might make this quadratic.
          {:safe, unquote(buffer ++ [text])}
        end
      end

      @doc false
      # Required for Elixir < v1.5.1
      def handle_expr("", marker, expr) do
        handle_expr({:safe, [""]}, marker, expr)
      end

      def handle_expr({:safe, buffer}, "=", expr) do
        line = line_from_expr(expr)
        expr = expr(expr)

        # FIXME:
        # Appending to the end of the list might make this quadratic.
        {:safe, buffer ++ [to_safe(expr, line)]}
      end

      def handle_expr({:safe, buffer}, "", expr) do
        expr = expr(expr)

        block_that_returns_nil =
          quote do
            unquote(expr)
            nil
          end

        # FIXME:
        # Appending to the end of the list might make this quadratic.
        {:safe, buffer ++ [block_that_returns_nil]}
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
  end
end
