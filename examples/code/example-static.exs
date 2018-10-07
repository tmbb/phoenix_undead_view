tmp_5_fixed =
  case(Plug.CSRFProtection.get_csrf_token_for(action)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_9_fixed =
  case(PhoenixUndeadView.Template.Widgets.Form.FormInputs.input_name_to_string(f)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_11_fixed =
  case(PhoenixUndeadView.Template.Widgets.Form.FormInputs.input_name_to_string(f)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_13_fixed =
  case(PhoenixUndeadView.Template.Widgets.Form.FormInputs.input_name_to_string(f)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_15_fixed =
  case(PhoenixUndeadView.Template.Widgets.Form.FormInputs.input_name_to_string(f)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_17_fixed =
  case(PhoenixUndeadView.Template.Widgets.Form.FormInputs.input_name_to_string(f)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_19_fixed =
  case(PhoenixUndeadView.Template.Widgets.Form.FormInputs.input_name_to_string(f)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

{:safe,
 [
   "\nBlah blah blah\n\n<form action=\"",
   "\" accept_charset=\"UTF-8\"><input name=\"_csrf_token\" type=\"hidden\" value=\"",
   tmp_5_fixed,
   "\"><input name=\"_utf8\" hidden=\"hidden\" value=\"✓\">",
   "\n  <input name=\"",
   tmp_9_fixed,
   "[name]\" id=\"",
   tmp_11_fixed,
   "_name\" type=\"text\">\n  <input name=\"",
   tmp_13_fixed,
   "[surname]\" id=\"",
   tmp_15_fixed,
   "_surname\" type=\"text\">\n  <input name=\"",
   tmp_17_fixed,
   "[age]\" id=\"",
   tmp_19_fixed,
   "_age\" type=\"number\">\n</form>\n\n",
   "\n\nBlah blah\n"
 ]}