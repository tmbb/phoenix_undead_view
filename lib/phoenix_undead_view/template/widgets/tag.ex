defmodule PhoenixUndeadView.Template.Widgets.Tag do
  @moduledoc """
  A widget to render an HTML tag
  """
  import PhoenixUndeadView.Template.Guards
  alias PhoenixUndeadView.Template.HTML
  require PhoenixUndeadView.Template.Segment, as: Segment
  alias PhoenixUndeadView.Template.Widgets.Attributes
  alias Plug.CSRFProtection
  import PhoenixUndeadView.Template.Guards

  @csrf_param "_csrf_token"
  @method_param "_method"

  defp get_method_from_opts(opts) do
    case Keyword.get(opts, :method, "post") do
      method when is_static(method) ->
        HTML.html_escape(method)

      method when is_dynamic(method) ->
        method
    end
  end

  def make_form_tag(action, opts) do
    method = get_method_from_opts(opts)

    method_segments =
      case method do
        "get" ->
          []

        "post" ->
          [make_csrf_token_tag(action, Keyword.put(opts, :method, "post"))]

        method ->
          [
            # Dummy input tag with the method passed by the user
            make_tag(:input, name: @method_param, type: "hidden", method: method),
            # The real method for the form is always "post"
            make_csrf_token_tag(action, Keyword.put(opts, :method, "post"))
          ]
      end

    method_container = Segment.undead_container(method_segments)

    # {opts, extra} =
    #   case Keyword.pop(opts, :enforce_utf8, true) do
    #     {false, opts} ->
    #       {opts, extra}

    #     {true, opts} ->
    #       {Keyword.put_new(opts, :accept_charset, "UTF-8"),
    #        extra <> ~s'<input name="_utf8" type="hidden" value="✓">'}
    #   end

    # opts =
    #   case Keyword.pop(opts, :multipart, false) do
    #     {false, opts} -> opts
    #     {true, opts} -> Keyword.put(opts, :enctype, "multipart/form-data")
    #   end

    Segment.undead_container([
      make_tag(:form, [action: action] ++ opts),
      method_container
    ])
  end

  def make_csrf_token_tag(to, opts) do
    case Keyword.get(opts, :csrf_token, true) do
      # A csrf token is required BUT hasn't been supplied.
      # It will be generated only once and won't be rerendered when the data changes,
      # so it will be given as a fixed segment.
      # Because we want the csrf_token to be a fixed segment (instead of a dynamic one),
      # we need to build the segments manually.
      true ->
        csrf_token = quote(do: CSRFProtection.get_csrf_token_for(unquote(to)))
        html_start = ~s'<input name="#{@csrf_param}" type="hidden" value="'
        html_end = ~s'">'

        Segment.undead_container([
          Segment.static(html_start),
          Segment.fixed(csrf_token),
          Segment.static(html_end)
        ])

      # A csrf_token is not necessary and won't be generated
      false ->
        Segment.undead_container([])

      # A csrf_token is required, has been supplied.
      # Its value can be static or dynamic, but the `make_tag/2` function will handle that.
      csrf_token ->
        make_tag(:input, name: @csrf_param, type: "hidden", value: csrf_token)
    end
  end

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

  def make_tag(name, attrs) do
    segments = tag_segments(name, attrs, nil)
    Segment.undead_container(segments)
  end

  def make_tag(name, attrs, do: contents) do
    segments = tag_segments(name, attrs, contents)
    Segment.undead_container(segments)
  end

  defmacro tag(name, attrs) do
    make_tag(name, attrs)
  end

  defmacro tag(name, attrs, do: contents) do
    make_tag(name, attrs, do: contents)
  end
end
