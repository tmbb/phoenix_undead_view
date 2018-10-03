defmodule PhoenixUndeadView.Template.UndeadEEx do
  require EEx
  alias PhoenixUndeadView.Template.{Optimizer, UndeadEngine}
  alias PhoenixUndeadView.UndeadTemplate

  def compile_string(text, opts) do
    env = Keyword.fetch!(opts, :env)
    raw = EEx.compile_string(text, engine: UndeadEngine)
    optimized = Optimizer.optimize(raw, env)

    %UndeadTemplate{
      raw: raw,
      full: optimized
    }
  end
end
