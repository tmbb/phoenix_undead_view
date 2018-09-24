{:safe,
 (
   dynamic__1 =
     (
       a = 1
       nil
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
         [
           "\n  ",
           case(a + 1) do
             {:safe, data} ->
               data

             bin when is_binary(bin) ->
               Plug.HTML.html_escape_to_iodata(bin)

             other ->
               Phoenix.HTML.Safe.to_iodata(other)
           end,
           "\n"
         ]
       else
         [
           "\n  ",
           case(a - 1) do
             {:safe, data} ->
               data

             bin when is_binary(bin) ->
               Plug.HTML.html_escape_to_iodata(bin)

             other ->
               Phoenix.HTML.Safe.to_iodata(other)
           end,
           "\n"
         ]
       end
     ) do
       {:safe, data} ->
         data

       bin when is_binary(bin) ->
         Plug.HTML.html_escape_to_iodata(bin)

       other ->
         Phoenix.HTML.Safe.to_iodata(other)
     end

   [dynamic__1, dynamic__2, dynamic__3]
 )}