# PhoenixUndeadView

Look at the `Fixtures` module in the `lib/fixtures.ex` file to see how it's used.

The engines can currently separate the dynamic from the static parts of the template, and without significant AST rewriting. You can find example outputs in the `examples/` directory.

## Structure

The `UndeadEngine` is now an implementation detail inaccessible to the user.
The user should never have to deal with the engine directly.

The main point of entry is the `UndeadEEx` module, which exports the `UndeadEEx.compile_string/2` function.
This function compiles the text into a `PhoenixUndeadView.%UndeadTemplate{}`, which contains quoted expressions for the full template, the static parts and the dynamic parts.

```
iex> alias PhoenixUndeadView.UndeadEEx
PhoenixUndeadView.UndeadEEx

iex> UndeadEEx.compile_string(text, env: __ENV__)
%PhoenixUndeadView.UndeadTemplate{
  # Quoted expression for the full template
  full: ...,
  # Quoted expression for the static parts
  static: ...,
  # Quoted expression for the dynamic parts
  dynamic: ...
}
```

## Naming of generated variables

The generated variables follow a naming convention.
For the top level, variable names are `dynamic__` followed by an integer.
For the inner levels, variable names are of the form `inner__#{level}_#{index}`.
It's possible that inner variable names will repeat, but that's not critical because we never refer to an inner variable in an outer level except in a very specific way.
Even if variables shadow each other, they won't shadow other variables in important places.

TODO: check if the above is true and explain it better.
It's not very easy because the EEx model of building quoted expressions is rather complex and not that intuitive.

## Limitations

It can't currently expand macros and optimize the results of the macro-expansion, which makes it currently rather useless.

One of the main places where you'd like to have server-driven dynamic UI would be in forms, and unless I can expand macros into flat lists, the whole form will be rendered as dynamic.

In any case, it's a good proof of concept.