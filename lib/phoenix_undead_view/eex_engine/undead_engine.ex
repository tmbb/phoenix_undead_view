defmodule PhoenixUndeadView.EExEngine.UndeadEngine do
  @moduledoc false

  alias PhoenixUndeadView.EExEngine.UndeadEngineImpl

  # This macro defines the functions that are common to all the engines.
  # Only the final processing done on the body of the template is specific to each template.
  defmacro __using__(_opts \\ []) do
    quote do
      use EEx.Engine

      @doc false
      def init(opts), do: UndeadEngineImpl.init(opts)

      @doc false
      def handle_begin(previous), do: UndeadEngineImpl.handle_begin(previous)

      @doc false
      def handle_end(expr), do: UndeadEngineImpl.handle_end(expr)

      @doc false
      def handle_text(buffer, text),
        do: UndeadEngineImpl.handle_text(buffer, text)

      @doc false
      def handle_expr(buffer, marker, expr),
        do: UndeadEngineImpl.handle_expr(buffer, marker, expr)
    end
  end
end
