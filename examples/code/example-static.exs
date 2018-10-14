tmp_4_fixed =
  case(fixed) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

{:safe, [["\n\nStatic part #1\n\n", tmp_4_fixed, "\n\n"], "\n\nStatic part #2\n"]}