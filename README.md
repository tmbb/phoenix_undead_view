# PhoenixUndeadView

Look at the `Fixtures` module in the `lib/fixtures.ex` file to see how it's used.

The engines can currently separate the dynamic from the static parts of the template, and without significant AST rewriting. You can find example outputs in the `examples/` directory.

## Limitations

This project already expands macros, but it still can't compile the templates into something that actually returns an iolist.

In any case, it's a good proof of concept.