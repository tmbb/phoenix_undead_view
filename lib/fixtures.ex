defmodule Fixtures do
  alias PhoenixUndeadView.EExEngine.Engines.{
    UndeadEngineFull,
    UndeadEngineDynamicParts,
    UndeadEngineStaticPartsUnoptimized,
    UndeadEngineStaticParts
  }

  @limit 100_000_000

  # Pretty print a quoted expression
  def pp_quoted(quoted) do
    quoted
    |> inspect(limit: @limit)
    |> Code.format_string!()
  end

  # Print a coded expression as code.
  # Printing a quoted expression into code is not a fully reverible operation!
  # The canonical result is always the quoted expression, not the code,
  # because the printed code plays ver badly with hygienic macros and stuff like that.
  def pp_as_code(quoted) do
    quoted
    |> Macro.to_string()
    |> Code.format_string!()
  end

  @engines [
    {UndeadEngineFull, "full"},
    {UndeadEngineStaticParts, "static"},
    {UndeadEngineStaticPartsUnoptimized, "static.unoptimized"},
    {UndeadEngineDynamicParts, "dynamic"}
  ]

  def example() do
    template = """
    <% a = 1 %>
    Blah blah blah
    <%= a %>
    Blah blah
    <%= if a > 1 do %>
      <%= a + 1 %>
    <% else %>
      <%= a - 1 %>
    <% end %>\
    """

    for {engine, name} <- @engines do
      compiled_undead =
        template
        |> EEx.compile_string(engine: engine)
        |> Macro.expand(__ENV__)

      # Ensure the template actually evaluates into something sensible without raising an error
      # and inspect the evaluation result
      Code.eval_quoted(compiled_undead, []) |> IO.inspect(label: name)

      File.write!("examples/example-quoted-#{name}.exs", pp_quoted(compiled_undead))
      File.write!("examples/example-code-#{name}.exs", pp_as_code(compiled_undead))
    end
  end
end