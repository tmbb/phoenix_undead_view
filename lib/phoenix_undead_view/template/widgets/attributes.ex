defmodule PhoenixUndeadView.Template.Widgets.Attributes do
  @moduledoc """
  Widgets that play well with Undead templates
  """
  import PhoenixUndeadView.Template.Guards
  alias PhoenixUndeadView.Template.{Segment, HTML}
  require Segment

  @type segment_tag() :: :static | :dynamic

  @type attr_name() :: binary() | integer() | atom()

  @type attr_value() :: binary() | integer() | atom()

  @type tagged_value() :: {segment_tag(), attr_value()}

  @type tagged_name() :: {segment_tag(), attr_name()}

  @type attr() :: {attr_name(), attr_value()}

  # The tag attributes are the most complex part of the tag.
  # Tag attribiutes are a list of key-value pairs.
  # The attribute name will be rendered as a string, but as a convenience
  # we allow the attribute names to be atoms, so that the attribute list
  # can be given as `[attr1: val1, attr2: val2]`.
  #
  # We want to optimize as much of the attribute list as possible,
  # We will do it by rendering parts of the list into static segments.
  #
  # To convert an attribute list into segments, we will:
  #
  #   1. render each attribute into segments
  #   2. intersperse the attribute with static whitespace segments
  #   3. join them all together.
  #   4. optimize the result by merging all adjacent static segments
  #
  # When we think about a single attribute (i.e. `{name, value}`),
  # there both `name` and `value` can be dynamic or static.
  # We need to analyze the AST representation of the attribute `name`
  # and `value` to tag them as either dynamic or static.

  @spec analyze_attribute(attr()) :: {{segment_tag(), attr_name()}, {segment_tag(), attr_value()}}
  def analyze_attribute({name, value} = _attribute) do
    analyzed_name =
      case name do
        name when is_static(name) -> {:static, name}
        Segment.undead_container() -> {:undead_container, name}
        name when is_dynamic(name) -> {:dynamic, name}
      end

    analyzed_value =
      case value do
        value when is_static(value) -> {:static, value}
        Segment.undead_container() -> {:undead_container, value}
        value when is_dynamic(value) -> {:dynamic, value}
      end

    {analyzed_name, analyzed_value}
  end

  @spec analyze_attributes(list(attr)) :: list({tagged_name(), tagged_value()})
  def analyze_attributes(attrs) when is_list(attrs) do
    Enum.map(attrs, &analyze_attribute/1)
  end

  # For a single attribute, there are 4 possible combinations,
  # which the following function handles quite explicitly

  def segments_for_attribute({{:static, name}, {:static, value}}) do
    binary = HTML.html_escape(name) <> ~s'="' <> HTML.html_escape(value) <> ~s'"'
    [Segment.static(binary)]
  end

  def segments_for_attribute({{:static, name}, {:dynamic, value}}) do
    escaped_name = HTML.html_escape(name)

    [
      Segment.static(~s'#{escaped_name}="'),
      Segment.dynamic(quote(do: HTML.html_escape(unquote(value)))),
      Segment.static(~s'"')
    ]
  end

  def segments_for_attribute({{:static, name}, {:undead_container, value}}) do
    escaped_name = HTML.html_escape(name)

    [
      Segment.static(~s'#{escaped_name}="'),
      value,
      Segment.static(~s'"')
    ]
  end

  # I doubt this will be used in practice...
  def segments_for_attribute({{:dynamic, name}, {:static, value}}) do
    escaped_value = ~s'"' <> HTML.html_escape(value) <> ~s'"'

    [
      Segment.dynamic(quote(do: HTML.html_escape(unquote(name)))),
      Segment.static(escaped_value)
    ]
  end

  def segments_for_attribute({{:dynamic, name}, {:dynamic, value}}) do
    [
      Segment.dynamic(quote(do: HTML.html_escape(unquote(name)))),
      Segment.static(~s'="'),
      Segment.dynamic(quote(do: HTML.html_escape(unquote(value)))),
      Segment.static(~s'"')
    ]
  end

  # I doubt this will be used in practice...
  def segments_for_attribute({{:dynamic, name}, {:undead_container, value}}) do
    [
      Segment.dynamic(quote(do: HTML.html_escape(unquote(name)))),
      Segment.static(~s'="'),
      value,
      Segment.static(~s'"')
    ]
  end

  def segments_for_attribute({{:undead_container, name}, {:static, value}}) do
    escaped_value = ~s'="' <> HTML.html_escape(value) <> ~s'"'

    [
      name,
      Segment.static(escaped_value)
    ]
  end

  def segments_for_attribute({{:undead_container, name}, {:dynamic, value}}) do
    [
      name,
      Segment.static(~s'="'),
      Segment.dynamic(quote(do: HTML.html_escape(unquote(value)))),
      Segment.static(~s'"')
    ]
  end

  # I doubt this will be used in practice...
  def segments_for_attribute({{:undead_container, name}, {:undead_container, value}}) do
    [
      name,
      Segment.static(~s'="'),
      value,
      Segment.static(~s'"')
    ]
  end

  # After turning a single attribute into segments,
  # we must insert whitespace between them.

  @doc false
  def insert_whitespace_between_attributes(attrs) do
    Enum.intersperse(attrs, [Segment.static(" ")])
  end

  # Now we can render the attributes into segments:
  def segments_for_attributes(attrs) when is_list(attrs) do
    segments =
      attrs
      |> analyze_attributes()
      |> Enum.map(&segments_for_attribute/1)
      |> insert_whitespace_between_attributes()

    segments
  end

  # TODO: handle the case in which the attrs are dynamic!
end
