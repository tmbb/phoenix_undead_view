defmodule PhoenixUndeadView.EExEngine.Context do
  defstruct [
    env: nil,
    buffer: nil,
    current: nil
  ]

  def new(opts) do
    struct(__MODULE__, opts)
  end
end