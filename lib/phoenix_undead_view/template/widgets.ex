defmodule PhoenixUndeadView.Template.Widgets do
  require PhoenixUndeadView.Template.Widgets.Tag, as: Tag

  defmacro tag(name, attrs) do
    quote do
      Tag.tag(unquote(name), unquote(attrs))
    end
  end
end