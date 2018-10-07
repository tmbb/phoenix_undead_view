tmp_5 =
  case(Plug.CSRFProtection.get_csrf_token_for(action)) do
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
   "\"><input name=\"_csrf_token\" type=\"hidden\" value=\"",
   tmp_5,
   "\">",
   "\n  <input name=\"user[name]\" id=\"user_name\" value=\"",
   "\">\n</form>\n\n",
   "\n\nBlah blah\n"
 ]}