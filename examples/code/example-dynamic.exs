a = 2

tmp_3_dynamic =
  case(PhoenixUndeadView.Template.HTML.html_escape(action)) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

f = Phoenix.HTML.FormData.to_form(fetch_assign(assigns, :changeset), [])

tmp_21_dynamic =
  case(a) do
    {:safe, data} ->
      data

    bin when is_binary(bin) ->
      Plug.HTML.html_escape_to_iodata(bin)

    other ->
      Phoenix.HTML.Safe.to_iodata(other)
  end

{:safe, [tmp_3_dynamic, tmp_21_dynamic]}