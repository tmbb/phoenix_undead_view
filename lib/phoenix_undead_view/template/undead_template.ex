defmodule PhoenixUndeadView.UndeadTemplate do
  @moduledoc """
  Kinda of a palceholder; needs to be refactored.
  """
  defstruct raw: nil,
            full: nil,
            static: nil,
            dynamic: nil

  def new(opts) do
    struct(__MODULE__, opts)
  end
end
