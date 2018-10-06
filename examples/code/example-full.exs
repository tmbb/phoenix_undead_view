a = 2

tmp_3 =
  case(PhoenixUndeadView.Template.HTML.html_escape(fetch_assign(assigns, :user).name())) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_5 =
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
   "\nBlah blah blah\n\n<input name=\"user[name]\" id=\"user_name\" value=\"",
   tmp_3,
   "\">\n\n",
   tmp_5,
   "\n\nBlah blah\n"
 ]}