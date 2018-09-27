dynamic__1 =
  (
    a = 2
    ""
  )

dynamic__2 =
  case(a) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

dynamic__3 =
  case(
    if(a > 1) do
      inner__1__1 = "\n  "

      inner__1__2 =
        case(a + 1) do
          {:safe, data} ->
            data

          bin when is_binary(bin) ->
            Plug.HTML.html_escape_to_iodata(bin)

          other ->
            Phoenix.HTML.Safe.to_iodata(other)
        end

      inner__1__3 = "\n  "

      inner__1__4 =
        case(
          if(3 > 1) do
            inner__2__1 = "\n    "

            inner__2__2 =
              case(1 + 5) do
                {:safe, data} ->
                  data

                bin when is_binary(bin) ->
                  Plug.HTML.html_escape_to_iodata(bin)

                other ->
                  Phoenix.HTML.Safe.to_iodata(other)
              end

            inner__2__3 = "\n  "
            [inner__2__1, inner__2__2, inner__2__3]
          end
        ) do
          {:safe, data} ->
            data

          bin when is_binary(bin) ->
            Plug.HTML.html_escape_to_iodata(bin)

          other ->
            Phoenix.HTML.Safe.to_iodata(other)
        end

      inner__1__5 = "\n"
      [inner__1__1, inner__1__2, inner__1__3, inner__1__4, inner__1__5]
    else
      inner__2__1 = "\n  "

      inner__2__2 =
        case(a - 1) do
          {:safe, data} ->
            data

          bin when is_binary(bin) ->
            Plug.HTML.html_escape_to_iodata(bin)

          other ->
            Phoenix.HTML.Safe.to_iodata(other)
        end

      inner__2__3 = "\n"
      [inner__2__1, inner__2__2, inner__2__3]
    end
  ) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

{:safe, ["", dynamic__1, "\nBlah blah blah\n", dynamic__2, "\nBlah blah\n", dynamic__3, ""]}