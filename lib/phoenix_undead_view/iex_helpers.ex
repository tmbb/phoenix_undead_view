defmodule PhoenixUndeadView.IExHelpers do
  def pp_as_code(quoted) do
    quoted
    |> Macro.to_string()
    |> Code.format_string!()
    |> IO.puts()
  end
end
