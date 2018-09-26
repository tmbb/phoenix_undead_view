# PhoenixUndeadView

Look at the `Fixtures` module in the `lib/fixtures.ex` file to see how it's used.

The engines can currently separate the dynamic from the static parts of the template, and without significant AST rewriting. You can find example outputs in the `examples/` directory.

## Structure

There are [4 engines](https://github.com/tmbb/phoenix_undead_view/tree/master/lib/phoenix_undead_view/eex_engine/engines). Only the following 3 are important (the other one is a relic which I keep around for reference purposes):

* [UndeadEngineFull](https://github.com/tmbb/phoenix_undead_view/blob/master/lib/phoenix_undead_view/eex_engine/engines/undead_engine_full.ex) - generates the full webpage/component, for the initial server-side rendering. This is the equivalent to what [Phoenix.HTML.Engine](https://github.com/phoenixframework/phoenix_html/blob/v2.12.0/lib/phoenix_html/engine.ex#L1) does already (and as you can see, the code was mostly copied from there). This template generates the following code: [quoted expressions](https://github.com/tmbb/phoenix_undead_view/blob/master/examples/example-quoted-full.exs); [code](https://github.com/tmbb/phoenix_undead_view/blob/master/examples/example-code-full.exs). The result is rendered to a list of alternating static and dynamic elements (i.e. static, dynamic, static, dynamic, ..., dynamic, static). The list always starts and ends with a binary (even if it i an empty one `""`), to make it easier to render the full text from diffs, but this can be optimized away if you don't need diffing (and normal Phoenix templates don't need it).

* [UndeadEngineDynamicParts](https://github.com/tmbb/phoenix_undead_view/blob/master/lib/phoenix_undead_view/eex_engine/engines/undead_engine_dynamic_parts.ex) - This engine renders only the dynamic parts rendered by the above template. The goal would be to render only the parts that change, send them over the network, and join them with the static parts on the client.

* [UndeadEngineStaticParts](https://github.com/tmbb/phoenix_undead_view/blob/master/lib/phoenix_undead_view/eex_engine/engines/undead_engine_static_parts.ex) - This engine renders only the static parts. The goal is to send these parts to the client only once so that the client knows how to merge the dynamic parts into the DOM. I think of this as a diff of the template (even though we are always diffing agains the static part, and not against the previous version)

A normal page render requires sending the output of the Full engine (as the literal DOM) and the StaticParts engine (compiled into a Javascript function that knows how to concat the dynamic parts it will receive later). Whenever the server wants to change the DOM on the client, it must run the DynamicParts engine (and only this one!) and send the list into the client, which will merge the dynamic parts into the textual HTML and merge it into the DOM.

If all you want is to compare my engine to Phoenix.HTML.Engine, you only need to look at the [UndeadEngineFull](https://github.com/tmbb/phoenix_undead_view/blob/master/examples/example-code-full.exs) and at its output. The output of the engine is a quoted expression, but you should format it into source code using `Macro.to_string()` and `Code.format_string!()` because the quoted expressions are quite unreadable, even for simple templates.

Now, my 3 engines contain some common functionality. In fact, only the `handle_body()` callback is different for each engine. To simplify things, I always use a [UndeadEngine](https://github.com/tmbb/phoenix_undead_view/blob/master/lib/phoenix_undead_view/eex_engine/undead_engine.ex), which contains the implementations of the common callbacks. Because I didn't want to define a lot of code in the `__using__` macro, I've put the actual implementation of the callbacks in the [UndeadEngineImpl](https://github.com/tmbb/phoenix_undead_view/blob/master/lib/phoenix_undead_view/eex_engine/undead_engine_impl.ex) module. While these layers of indirections make my project more complex, they're kinda required if I want to work on 3 similar engines at the same time, but you don't need any of these if you only want the Full engine.

You might need to read the `Utils` and `Merger` modules, which build and optimize the final AST.


## Naming of generated variables

The generated variables follow a naming convention.
For the top level, variable names are `static__` and `dynamic__`, followed by an integer.
For the inner levels, variable names are of the form `inner__#{level}_#{index}`.
It's possible that inner variable names will repeat, but that's not critical because we never refer to an inner variable in an outer level except in a very specific way.
Even if variables shadow each other, they won't shadow other variables in important places.

TODO: check if the above is true and explain it better.
It's not very easy because the EEx model of building quoted expressions is rather complex and not that intuitive.

## Limitations

It can't currently expand macros and optimize the results of the macro-expansion, which makes it currently rather useless.

One of the main places where you'd like to have server-driven dynamic UI would be in forms, and unless I can expand macros into flat lists, the whole form will be rendered as dynamic.

In any case, it's a good proof of concept.