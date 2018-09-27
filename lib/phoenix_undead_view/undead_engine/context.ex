defmodule PhoenixUndeadView.UndeadEngine.Context do
  alias PhoenixUndeadView.UndeadEngine.Context

  defstruct [
    env: nil,
    buffer: [""],
    level: 0,
    buffer_reversed?: false
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

  def prepend_to_buffer(%Context{buffer: buffer, buffer_reversed?: false} = context, value) do
    %{context | buffer: [value | buffer]}
  end

  def reverse_buffer(%Context{buffer: buffer, buffer_reversed?: buffer_reversed?} = context) do
    %{context | buffer: :lists.reverse(buffer), buffer_reversed?: not buffer_reversed?}
  end
end