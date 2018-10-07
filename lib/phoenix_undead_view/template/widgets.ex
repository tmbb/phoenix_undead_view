defmodule PhoenixUndeadView.Template.Widgets do
  alias PhoenixUndeadView.Template.Widgets.Tag
  alias PhoenixUndeadView.Template.Widgets.Form

  defmacro tag(name, attrs) do
    Tag.make_tag(name, attrs)
  end

  defmacro tag(name, attrs, do: contents) do
    Tag.make_tag(name, attrs, do: contents)
  end

  defmacro form(form_data, action, options, fun) do
    Form.make_form(form_data, action, options, fun)
  end
end
