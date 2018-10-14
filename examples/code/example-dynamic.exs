a = 2
fixed = a

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

{:safe, [tmp_6_dynamic]}