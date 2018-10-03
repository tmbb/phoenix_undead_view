defmodule Fixtures do
  alias PhoenixUndeadView.Template.UndeadEEx
  import PhoenixUndeadView.Template.Widgets.Tag
  require EEx

  _no_warning = tag(:x, [])

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

  defmacro f(x) do
    x
  end

  def example() do
    template = """
    <% a = 2 %>
    Blah blah blah

    <%= tag(:input, [name: "user[name]", id: "user_name", value: @user.name]) %>

    <%= a %>

    Blah blah
    """

    undead_template = UndeadEEx.compile_string(template, env: __ENV__)
    expr = undead_template.raw
    File.write!("examples/quoted/example-raw.exs", pp_quoted(expr))
    File.write!("examples/code/example-raw.exs", pp_as_code(expr))

    optimized = undead_template.full
    File.write!("examples/quoted/example-optimized.exs", pp_quoted(optimized))
    File.write!("examples/code/example-optimized.exs", pp_as_code(optimized))

    :ok
  end
end
