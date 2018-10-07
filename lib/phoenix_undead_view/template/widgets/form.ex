defmodule PhoenixUndeadView.Template.Widgets.Form do
  @moduledoc false
  import PhoenixUndeadView.Template.Guards
  require PhoenixUndeadView.Template.Widgets.Tag, as: Tag
  require PhoenixUndeadView.Template.Segment, as: Segment
  alias Phoenix.HTML.FormData
  alias PhoenixUndeadView.Template.Widgets.Form.FormInputs

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

  defmacro number_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:number, form, field, opts)
  end

  defmacro email_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:email, form, field, opts)
  end

  defmacro password_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:password, form, field, opts)
  end

  defmacro url_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:url, form, field, opts)
  end

  defmacro search_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:search, form, field, opts)
  end

  defmacro telephone_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:telephone, form, field, opts)
  end

  defmacro color_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:color, form, field, opts)
  end

  defmacro range_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:range, form, field, opts)
  end

  defmacro date_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:date, form, field, opts)
  end

  defmacro datetime_local_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:datetime_local, form, field, opts)
  end

  defmacro text_input(form, field, opts \\ []) do
    FormInputs.make_generic_input(:text, form, field, opts)
  end
end
