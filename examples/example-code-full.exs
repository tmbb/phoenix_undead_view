{:safe,
 (
   static__1 = ""

   dynamic__1 =
     (
       a = 1
       nil
     )

   static__2 = "\nBlah blah blah\n"

   dynamic__2 =
     case(a) do
       {:safe, data} ->
         data

       bin when is_binary(bin) ->
         Plug.HTML.html_escape_to_iodata(bin)

       other ->
         Phoenix.HTML.Safe.to_iodata(other)
     end

   static__3 = "\nBlah blah\n"

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

   static__4 = ""
   [static__1, dynamic__1, static__2, dynamic__2, static__3, dynamic__3, static__4]
 )}