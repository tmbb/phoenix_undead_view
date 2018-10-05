defmodule PhoenixUndeadView.Template.Widgets.Tag do
  @moduledoc """
  A widget to render an HTML tag
  """
  import PhoenixUndeadView.Template.Guards
  alias PhoenixUndeadView.Template.{HTML, Segment}
  alias PhoenixUndeadView.Template.Widgets.Attributes

  def segments_for_tag_name(name) when is_static(name) do
    [Segment.static(HTML.html_escape(name))]
  end

  def segments_for_tag_name(name) do
    Segment.static(quote(do: HTML.html_escape(unquote(name))))
  end

  def segments_for_opening_tag(name, attrs) do
    segments_for_attributes =
      case Attributes.segments_for_attributes(attrs) do
        [] -> []
        segments -> [Segment.static(" ") | segments]
      end

    segments_for_tag_name = segments_for_tag_name(name)

    nested = [
      Segment.static("<"),
      segments_for_tag_name,
      segments_for_attributes,
      Segment.static(">")
    ]

    List.flatten(nested)
  end

  def segments_for_closing_tag(name) when is_static(name) do
    [Segment.static("</" <> HTML.html_escape(name) <> ">")]
  end

  def segments_for_closing_tag(name) when is_static(name) do
    [
      Segment.static("</"),
      Segment.dynamic(quote(do: HTML.html_escape(unquote(name)))),
      Segment.static(">")
    ]
  end

  def segments_for_contents(_contents), do: []

  def tag_segments(name, attrs, contents) do
    opening_tag = segments_for_opening_tag(name, attrs)
    tag_contents = segments_for_contents(contents)

    closing_tag =
      if is_nil(contents) do
        []
      else
        segments_for_closing_tag(name)
      end

    opening_tag ++ tag_contents ++ closing_tag
  end

  defmacro tag(name, attrs) do
    segments = tag_segments(name, attrs, nil)
    Segment.undead_containter(segments)
  end

  defmacro tag(name, attrs, do: contents) do
    segments = tag_segments(name, attrs, contents)
    Segment.undead_containter(segments)
  end
end
