# PhoenixUndeadView

Look at the `Fixtures` module in the `lib/fixtures.ex` file to see how it's used.

The engines can currently separate the dynamic from the static parts of the template, and without significant AST rewriting! It can now take this template:

```
<% a = 1 %>
Blah blah blah
<%= a %>
Blah blah
<%= if a > 1 do %>
  <%= a + 1 %>
<% else %>
  <%= a - 1 %>
<% end %>
```

... compile it into the following (full template):

```elixir
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
```

And separate the static parts...

```elixir
{:safe, ["", "\nBlah blah blah\n", "\nBlah blah\n", ""]}
```

From the dynamic parts:

```elixir
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
```

## Limitations

It can't currently expand macros and optimize the results of the macro-expansion, which makes it currently rather useless. In any case, it's a good proof of concept.