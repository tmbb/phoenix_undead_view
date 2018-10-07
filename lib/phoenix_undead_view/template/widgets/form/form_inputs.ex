defmodule PhoenixUndeadView.Template.Widgets.Form.FormInputs do
  @moduledoc false
  import PhoenixUndeadView.Template.Guards
  require PhoenixUndeadView.Template.Widgets.Tag, as: Tag
  require PhoenixUndeadView.Template.Segment, as: Segment
  alias PhoenixUndeadView.Template.Widgets.Form.FormInputs

  def input_name(%{name: name}, field) when is_atom(field) or is_binary(field),
    do: "#{name}[#{field}]"

  def input_name(name, field) when (is_atom(name) and is_atom(field)) or is_binary(field),
    do: "#{name}[#{field}]"

  def input_id(%{name: name}, field) when is_atom(field) or is_binary(field),
    do: "#{name}_#{field}"

  def input_id(name, field) when (is_atom(name) and is_atom(field)) or is_binary(field),
    do: "#{name}_#{field}"

  @doc false
  def input_name_to_string(%{name: name}), do: to_string(name)

  def input_name_to_string(name) when is_atom(name) or is_binary(name), do: to_string(name)

  # Generate input name (e.g. `"#{name}[#{field}]"`)

  defp make_input_name_segments(name, field) when is_static(name) and is_static(field) do
    [Segment.static(input_name(name, field))]
  end

  defp make_input_name_segments(name, field) when is_static(name) and is_dynamic(field) do
    [
      Segment.static("#{name}["),
      Segment.fixed(quote(do: to_string(unquote(field)))),
      Segment.static("]")
    ]
  end

  defp make_input_name_segments(name, field) when is_dynamic(name) and is_static(field) do
    [
      Segment.fixed(quote(do: unquote(__MODULE__).input_name_to_string(unquote(name)))),
      Segment.static("[#{field}]")
    ]
  end

  defp make_input_name_segments(name, field) when is_dynamic(name) and is_dynamic(field) do
    [
      Segment.fixed(quote(do: unquote(__MODULE__).input_name_to_string(unquote(name)))),
      Segment.static("["),
      Segment.fixed(quote(do: to_string(unquote(field)))),
      Segment.static("]")
    ]
  end

  # Generate input ID (i.e. `"#{name}_#{field}"`)

  defp make_input_id_segments(name, field) when is_static(name) and is_static(field) do
    [Segment.static(input_id(name, field))]
  end

  defp make_input_id_segments(name, field) when is_static(name) and is_dynamic(field) do
    [
      Segment.static("#{name}_"),
      Segment.fixed(quote(do: to_string(unquote(field))))
    ]
  end

  defp make_input_id_segments(name, field) when is_dynamic(name) and is_static(field) do
    [
      Segment.fixed(quote(do: unquote(__MODULE__).input_name_to_string(unquote(name)))),
      Segment.static("_#{field}")
    ]
  end

  defp make_input_id_segments(name, field) when is_dynamic(name) and is_dynamic(field) do
    [
      Segment.fixed(quote(do: unquote(__MODULE__).input_name_to_string(unquote(name)))),
      Segment.static("_"),
      Segment.fixed(quote(do: to_string(unquote(field))))
    ]
  end

  defp make_input_name(name, field) do
    segments = make_input_name_segments(name, field)
    Segment.undead_container(segments)
  end

  defp make_input_id(name, field) do
    segments = make_input_id_segments(name, field)
    Segment.undead_container(segments)
  end

  def make_generic_input(type, form, field, opts)
      when is_list(opts) and (is_atom(field) or is_binary(field)) do
    name = make_input_name(form, field)
    id = make_input_id(form, field)

    opts =
      opts
      |> Keyword.put_new(:type, type)
      |> Keyword.put_new(:id, id)
      # |> Keyword.put_new(:value, input_value(form, field))
      # |> Keyword.update!(:value, &maybe_html_escape/1)
      |> Keyword.put_new(:name, name)

    Tag.make_tag(:input, opts)
  end
end
