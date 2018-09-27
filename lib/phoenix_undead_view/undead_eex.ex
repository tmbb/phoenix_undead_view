

defmodule PhoenixUndeadView.UndeadEEx do
  alias PhoenixUndeadView.UndeadEngine
  alias PhoenixUndeadView.UndeadTemplate
  alias PhoenixUndeadView.UndeadEngine.Postprocess

  def compile_string(text, opts) do
    env = Keyword.fetch!(opts, :env)
    full = EEx.compile_string(text, engine: UndeadEngine, opts: [env: env])
    static = Postprocess.compile_static(full)
    dynamic = Postprocess.compile_dynamic(full)

    %UndeadTemplate{
      full: full,
      static: static,
      dynamic: dynamic
    }
  end
end