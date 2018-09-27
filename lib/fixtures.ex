defmodule Fixtures do
  alias PhoenixUndeadView.UndeadEEx

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

  def example() do
    template = """
    <% a = 2 %>
    Blah blah blah
    <%= a %>
    Blah blah
    <%= if a > 1 do %>
      <%= a + 1 %>
      <%= if 3 > 1 do %>
        <%= 1 + 5 %>
      <% end %>
    <% else %>
      <%= a - 1 %>
    <% end %>\
    """

    undead_template = UndeadEEx.compile_string(template, env: __ENV__)

    templates = [
      {undead_template.full, "full"},
      {undead_template.static, "static"},
      {undead_template.dynamic, "dynamic"}
    ]

    for {quoted, name} <- templates do
      File.write!("examples/quoted/example-#{name}.exs", pp_quoted(quoted))
      File.write!("examples/code/example-#{name}.exs", pp_as_code(quoted))
      {iodata, _} = Code.eval_quoted(quoted, [])
      IO.inspect(iodata, label: name)
    end

    :ok
  end
end
