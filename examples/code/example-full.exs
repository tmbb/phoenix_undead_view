a = 2

tmp_3 =
  case(PhoenixUndeadView.Template.HTML.html_escape(action)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_5 =
  case(Plug.CSRFProtection.get_csrf_token_for(action)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

f = Phoenix.HTML.FormData.to_form(fetch_assign(assigns, :changeset), [])

tmp_9 =
  case(PhoenixUndeadView.Template.HTML.html_escape(fetch_assign(assigns, :user).name())) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_11 =
  case(a) do
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
   tmp_3,
   "\"><input name=\"_csrf_token\" type=\"hidden\" value=\"",
   tmp_5,
   "\">",
   "\n  <input name=\"user[name]\" id=\"user_name\" value=\"",
   tmp_9,
   "\">\n</form>\n\n",
   tmp_11,
   "\n\nBlah blah\n"
 ]}