defmodule Fixtures do
  alias PhoenixUndeadView.Template.UndeadEEx
  # import PhoenixUndeadView.Template.Widgets.Form
  import PhoenixUndeadView.Template.Widgets
  import PhoenixUndeadView.Template.Widgets.Form
  require EEx

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

  template = """
  <% a = 2 %>
  <% fixed = a %>
  Static part #1

  <%/ fixed %>

  <%= if a > 1 do %>
    <%= a %>
  <% else %>
    Nope
  <% end %>

  Static part #2
  """

  @template template

  undead_template = UndeadEEx.compile_string(template, env: __ENV__)

  def render(assigns) do
    unquote(undead_template.full)
  end

  def example() do
    template = @template

    undead_template = UndeadEEx.compile_string(template, env: __ENV__)

    data = [
      {"raw", undead_template.raw},
      {"full", undead_template.full},
      {"dynamic", undead_template.dynamic},
      {"static", undead_template.static}
    ]

    for {name, quoted} <- data do
      File.write!("examples/quoted/example-#{name}.exs", pp_quoted(quoted))
      File.write!("examples/code/example-#{name}.exs", pp_as_code(quoted))
    end

    :ok
  end
end
