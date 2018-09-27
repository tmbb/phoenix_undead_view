defmodule PhoenixUndeadView.UndeadTemplate do
  defstruct [
    full: nil,
    static: nil,
    dynamic: nil
  ]

  def new(opts) do
    struct(__MODULE__, opts)
  end
end