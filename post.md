### Major Changes

I've been more or less blinded by the idea that the EEx templates should return something that's similar to a quoted expression. As @josevalim said some time ago, this is a mistake. I've lost a couple hours which I'll never get back for not listening to his advice. This tells me I should following to his advice next time. Or not, who knows...

So this is how it will work now:

The engine will no longer compile the text into a real quoted expression. I'll make it so that it compiles into a structure made from tuples and lists of 2-tuples. I like to think of 2-tuples as algebraic data types, and it would help if Elixir supported real algebraic data types, but well, we have to make do with what we have.

The "datatype" of the intermediate EEx templates would be the following:

```
{:undead_eex,
  [
    # static text
    {:static, "static binary"},
    # <%= ... %>
    {:dynamic, expr1},
    # <% ... %>
    {:support, expr2}
    # <%| ... %>
    {:fixed, expr2}
    ...
  ]}
```

The critical thing is that I can nest an `{:undead_eex, _}` template inside the `{:dynamic, _}` constructor. This nested template could be the result of expanding a macro inside a `:dynamic` segment. For example, I could have:

```
{:undead_eex,
  [
    segment1,
    segment2,
    {:dynamic, expression_with_a_macro},
    segment3,
    segment4
  ]}
```

After expanding the macro (inside the UndeadEEx engine or in a postprocessing step), this could return the following template:

```
{:undead_eex,
  [
    segment1,
    segment2,
    {:dynamic, {:undead_eex, contents}}
    segment3,
    segment4
  ]}
```

I can statically simplify this into:

```
{:undead_eex,
  [
    segment1,
    segment2
  ] ++ contents ++ [
    segment3,
    segment4
  ]}
```

I am now compiling the text into such an abstract format, which preserves interesting semantic distinctions between the several types of segments (instead of a quoted expression, which kinda blends everything together in executable Elixir code).

I can apply valid algebraic transformations to this structure in order to optimize it further. The transformation above is an example (actually the only one I can think of right now). The following expressions are equivalent:

```
{:dynamic, {:undead_eex, contents}} # is equivalent to...
contents
```

It's possible that there are other valid transformations I can apply, but the important is the idea.

This is all a bit abstract, so let me show how this can be quite useful.

#### A template is a 2-tuple

As I said, a *compiled template* is a 2-tuple of the form `{:undead_eex, contents}`. Templates are fed into the Engine as text files. A compiled template is the "raw" result of compiling a text file with the `UndeadEngine`.

This compiled template is not very useful by itself. It's not a quoted expression which you splice into Elixir's AST to get some executable code. You should think of it as an intermediate representation in a compiler

#### Templates can be nested inside each other

Because a template is simply a data structure, it's obvious we can nest them inside each other:

```
{:undead_eex,
  [
    ...,
    {:dynamic, {:undead_eex,
      [
        {:dynamic, {:undead_eex, ...}}
      ]}},
      ...
  ]}
```

When we have nested templates, we can always apply the rule above to flatten them into a single template.

#### We can define reusable widgets

We can define reusable widgets as macros. Those macros will be expanded into templates (which are a data structure and not a quoted expression representing executable code!).

If you have a `my_widget(arg1)` macro inside a `:dynamic` segment, it will be expanded. If the result of the expansion is a valid compiled template (i.e. `{:undead_eex, ...}`), it can be flattened into the parent template.

This is great for optimization, because we can merge adjacent binaries.

#### (Some) Widgets in `phoenix_html` can be reimplemented as macros

The `phoenix_html` package defines a number of widgets, implemented as functions. For example:

```
iex> import Phoenix.HTML.Tag
Phoenix.HTML.Tag
iex> tag(:input, [id: "user_name", name: "user[name]", type: "text", value: "value"]) |> Phoenix.HTML.safe_to_string()
"<input id=\"user_name\" name=\"user[name]\" type=\"text\" value=\"value\">"
```

We can reimplement the `tag` widget as a macro that expands into a complete `{:undead_eex, ...}` template, which will be embedded in a larger template and ultimately flattened into the larger template (for further optimization). For example, let's try to relicate the above:

```
iex> import PhoenixUndeadView.Widgets
PhoenixUndeadView.Widgets
iex> Macro.expand(quote(do: tag(:input, [id: "user_name", name: "user[name]", type: "text", value: "value"])), __ENV__)
{:undead_eex,
 [
   static: "<input id=\"user_name\" name=\"user[name]\" type=\"text\" value=\"value\">"
 ]}
```

The output is pretty much the same (except that it is properly tagged as a compiled template should be). But values in input tags are often dynamic. So let's make it dynamic:

```
iex> Macro.expand(quote(do: tag(:input, [id: "user_name", name: "user[name]", type: "text", value: @user.name])), __ENV__)
{:undead_eex,
 [
   static: "<input id=\"user_name\" name=\"user[name]\" type=\"text\" value=\"",
   dynamic: {:html_escape,
    [context: PhoenixUndeadView.Widgets, import: Phoenix.HTML],
    [
      {{:., [],
        [
          {:@, [context: Elixir, import: Kernel],
           [{:user, [context: Elixir], Elixir}]},
          :name
        ]}, [], []}
    ]},
   static: "\">"
 ]}
```

We get a much more interesting compiled template, which follows the main design rules of `PhoenixUndeadView`

1. What is static is always static
2. What is dynamic is always dynamic

The above would be transformed so that `@user.name` becomes something like `assigns[:user][:name]` or something like that, but the `UndeadEngine` already handles that part.

The fact that `tag` is now a macro that receives literal AST terms allows me to split the attribute list into static and dynamic parts and optimize it by merging all static parts together. This is a simple but very high-yield optimization.

If this macro is expanded inside a larger template, the static part at the beginning and the end can be merged with other binaries, thus increasing efficiency.

There *might* still be some problems with variable scope , but I'm pretty happy with the general idea. I think there shuoldn't be any actual problems, but I haven't tested this properly yet in the "real world".

#### Things might get even more succinct with sigils

I have reimplemented the `tag` template by creating the tuples above "by hand".
If we define a `~U""` sigil (from **u**ndead) which returns a compiled template, we might define widgets in a more natural way by making them macros that return the sigil.

That's not something I'd do with the `tag` macro because it needs to support a variable number of attributes, but it might make sense in other cases where everything has a fixed number of arguments.

#### Plans for the future

I'll reimplement most widgets in `Phoenix.HTML` as macros and reimplement the engine so that it can make use of these templates.

I still haven't found a good way to reimplement `form_for`, one can get good results with something like:

```plaintext
<% form <- FormData.to_form(@changeset, options) %>
<%= form_tag "/url", method: "post" do %>
  <%= text_input(form, :name) %>
  <%= text_input(form, :surname) %>
<% end %>
```

where `form_tag/3` and `text_input/2` are macros.

In particular, `form_tag/3` mus be a macro that expands its body.