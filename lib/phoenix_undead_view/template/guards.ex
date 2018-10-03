defmodule PhoenixUndeadView.Template.Guards do
  @moduledoc """
  Some guards to make pattern matching less verbose
  """

  @doc """
  Tests whether a value is static.

  Static values are:

    1. binaries
    2. integers
    3. atoms
  """
  defguard is_static(value) when is_binary(value) or is_integer(value) or is_atom(value)

  @doc """
  Tests whether a value is dynamic.

  Everything that's not static is dynamic (e.g. variables, function calls)
  """
  defguard is_dynamic(value) when not is_static(value)
end
