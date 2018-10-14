_ = assigns
element_id = Integer.to_string(:rand.uniform(4_294_967_296), 32)
a = 2
fixed = a

tmp_4_fixed =
  case(fixed) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

tmp_6_dynamic =
  case(
    case(a > 1) do
      x when :erlang.orelse(:erlang."=:="(x, nil), :erlang."=:="(x, false)) ->
        {:safe, ["\n  Nope\n"]}

      _ ->
        tmp_2_2_dynamic =
          case(a) do
            {:safe, data} ->
              data

            bin when is_binary(bin) ->
              Plug.HTML.html_escape_to_iodata(bin)

            other ->
              Phoenix.HTML.Safe.to_iodata(other)
          end

        {:safe, ["\n  ", tmp_2_2_dynamic, "\n"]}
    end
  ) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

{:safe,
 [
   "<span id=\"",
   element_id,
   "\">\n\nStatic part #1\n\n",
   tmp_4_fixed,
   "\n\n",
   tmp_6_dynamic,
   "\n\nStatic part #2\n</span>\n\n<script type=\"application/json\" undead-id=\"",
   element_id,
   "\">\n[\n  \"\",\n  \"\\n\\nStatic part #1\\n\\n",
   Phoenix.HTML.escape_javascript(tmp_4_fixed),
   "\\n\\n\",\n  \"\\n\\nStatic part #2\\n\"\n]\n</script>"
 ]}