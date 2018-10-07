defmodule PhoenixUndeadView.Template.Segment do
  @undead_container_tag UndeadEngine.Segment.UndeadContainer
  @static_tag UndeadEngine.Segment.Static
  @dynamic_tag UndeadEngine.Segment.Dynamic
  @support_tag UndeadEngine.Segment.Support
  @fixed_tag UndeadEngine.Segment.Fixedw

  defguard is_segment(segment)
           when tuple_size(segment) == 2 and tuple_size(elem(segment, 1)) == 2 and
                  elem(segment, 0) in [
                    @undead_container_tag,
                    @static_tag,
                    @dynamic_tag,
                    @support_tag,
                    @fixed_tag
                  ]

  def line({_tag, {_contents, meta}}) do
    Keyword.get(meta, :line)
  end

  defmacro segment(contents) do
    quote do
      {tag, {unquote(contents), _meta}}
    end
  end

  defmacro segment(contents, meta) do
    quote do
      {tag, {unquote(contents), unquote(meta)}}
    end
  end

  def update({tag, {_contents, meta}}, contents) do
    {tag, {contents, meta}}
  end

  def update({tag, {_contents, _meta}}, contents, meta) do
    {tag, {contents, meta}}
  end

  defmacro undead_container() do
    quote do
      {unquote(@undead_container_tag), {_contents, _meta}}
    end
  end

  defmacro undead_container(contents, meta \\ []) do
    quote do
      {unquote(@undead_container_tag), {unquote(contents), unquote(meta)}}
    end
  end

  defmacro static() do
    quote do
      {unquote(@static_tag), {_contents, _meta}}
    end
  end

  defmacro static(contents, meta \\ []) do
    quote do
      {unquote(@static_tag), {unquote(contents), unquote(meta)}}
    end
  end

  defmacro dynamic() do
    quote do
      {unquote(@dynamic_tag), {_contents, _meta}}
    end
  end

  defmacro dynamic(contents, meta \\ []) do
    quote do
      {unquote(@dynamic_tag), {unquote(contents), unquote(meta)}}
    end
  end

  defmacro support() do
    quote do
      {unquote(@support_tag), {_contents, _meta}}
    end
  end

  defmacro support(contents, meta \\ []) do
    quote do
      {unquote(@support_tag), {unquote(contents), unquote(meta)}}
    end
  end

  defmacro fixed() do
    quote do
      {unquote(@fixed_tag), {_contents, _meta}}
    end
  end

  defmacro fixed(contents, meta \\ []) do
    quote do
      {unquote(@fixed_tag), {unquote(contents), unquote(meta)}}
    end
  end
end
