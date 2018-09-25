defmodule PhoenixUndeadView.EExEngine.Context do
  alias PhoenixUndeadView.EExEngine.Context

  defstruct [
    env: nil,
    buffer: [""],
    type: nil
  ]

  def new(opts) do
    struct(__MODULE__, opts)
  end

  def new_toplevel(opts) when is_list(opts) do
    struct(__MODULE__, Keyword.merge(opts, [type: :toplevel]))
  end

  def new_inner(opts) when is_list(opts) do
    struct(__MODULE__, Keyword.merge(opts, [type: :inner]))
  end

  def append_to_buffer(%Context{buffer: buffer} = context, value) do
    %{context | buffer: buffer ++ [value]}
  end

  def replace_buffer(%Context{} = context, value) do
    %{context | buffer: value}
  end
end