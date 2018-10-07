defmodule PhoenixUndeadView.Template.Widgets.Form do
  @moduledoc false
  alias Phoenix.HTML.FormData
  require PhoenixUndeadView.Template.Widgets.Tag, as: Tag
  require PhoenixUndeadView.Template.Segment, as: Segment

  defp validate_fun_arg({_name, _meta, context} = _var) when is_atom(context), do: true

  defp validate_fun_arg(other) do
    raise ArgumentError, inspect(other)
  end

  def hygienize_var({name, meta, _context} = _var), do: {name, meta, __MODULE__}

  defp substitute(ast, old, new) do
    Macro.prewalk(ast, fn
      ^old -> new
      other -> other
    end)
  end

  def make_form(form_data, action, options, fun) do
    {:fn, _,
     [
       {:->, _,
        [
          [arg],
          body
        ]}
     ]} = fun

    validate_fun_arg(arg)
    hygienic_var = hygienize_var(arg)
    substituted_body = substitute(body, arg, hygienic_var)

    {UndeadEngine.Segment.UndeadContainer,
     {[
        {UndeadEngine.Segment.UndeadContainer,
         {[
            {UndeadEngine.Segment.Static,
             {"<input name=\"_csrf_token\" type=\"hidden\" value=\"", []}},
            {UndeadEngine.Segment.Fixed,
             {{{:., [], [Plug.CSRFProtection, :get_csrf_token_for]}, [],
               [{:action, [line: 4], nil}]}, []}},
            {UndeadEngine.Segment.Static, {"\">", []}}
          ], []}}
      ], []}}

    open_form = Tag.make_form_tag(action, options)

    hygienic_assignment =
      quote do
        unquote(hygienic_var) = FormData.to_form(unquote(form_data), unquote(options))
      end

    close_form = Segment.static("</form>")

    Segment.undead_container([
      open_form,
      Segment.support(hygienic_assignment),
      substituted_body,
      close_form
    ])
  end

  defmacro form(form_data, action, options, fun) do
    make_form(form_data, action, options, fun)
  end
end
