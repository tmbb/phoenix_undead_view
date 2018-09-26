defmodule PhoenixUndeadView.EExEngine.Context do
  alias PhoenixUndeadView.EExEngine.Context

  defstruct [
    env: nil,
    buffer: [""],
    level: 0
  ]

  def new(opts) do
    struct(__MODULE__, opts)
  end

  def new_toplevel(opts) when is_list(opts) do
    struct(__MODULE__, Keyword.merge(opts, [level: 0]))
  end

  def move_to_next_level(%Context{level: level} = context) do
    %{context | buffer: [""], level: level + 1}
  end

  def append_to_buffer(%Context{buffer: buffer} = context, value) do
    %{context | buffer: buffer ++ [value]}
  end
end