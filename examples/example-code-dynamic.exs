{:safe,
 (
   dynamic__1 =
     (
       a = 1
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
         inner__1 = "\n  "

         inner__2 =
           case(f(6)) do
             {:safe, data} ->
               data

             bin when is_binary(bin) ->
               Plug.HTML.html_escape_to_iodata(bin)

             other ->
               Phoenix.HTML.Safe.to_iodata(other)
           end

         inner__3 = "\n  "

         inner__4 =
           case(a + 1) do
             {:safe, data} ->
               data

             bin when is_binary(bin) ->
               Plug.HTML.html_escape_to_iodata(bin)

             other ->
               Phoenix.HTML.Safe.to_iodata(other)
           end

         inner__5 = "\n"
         [inner__1, inner__2, inner__3, inner__4, inner__5]
       else
         inner__1 = "\n  "

         inner__2 =
           case(a - 1) do
             {:safe, data} ->
               data

             bin when is_binary(bin) ->
               Plug.HTML.html_escape_to_iodata(bin)

             other ->
               Phoenix.HTML.Safe.to_iodata(other)
           end

         inner__3 = "\n"
         [inner__1, inner__2, inner__3]
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