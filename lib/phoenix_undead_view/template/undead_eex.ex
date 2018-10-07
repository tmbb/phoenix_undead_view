defmodule PhoenixUndeadView.Template.UndeadEEx do
  require EEx

  alias PhoenixUndeadView.Template.{
    Optimizer,
    Compiler,
    UndeadTemplate,
    UndeadEngine
  }

  alias PhoenixUndeadView.Template.UndeadTemplate

  def compile_string(text, opts) do
    env = Keyword.fetch!(opts, :env)
    raw = EEx.compile_string(text, engine: UndeadEngine)
    optimized = Optimizer.optimize(raw, env)
    full = Compiler.compile_full(optimized)
    static = Compiler.compile_static(optimized)
    dynamic = Compiler.compile_dynamic(optimized)

    %UndeadTemplate{
      raw: raw,
      full: full,
      static: static,
      dynamic: dynamic
    }
  end
end
