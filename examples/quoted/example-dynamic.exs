{:__block__, [],
 [
   {:=, [line: 1], [{:a, [line: 1], nil}, 2]},
   {:=, [],
    [
      {:tmp_3_dynamic, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {{:., [], [PhoenixUndeadView.Template.HTML, :html_escape]}, [],
          [{:action, [line: 4], nil}]},
         [
           do: [
             {:->, [generated: true],
              [
                [safe: {:data, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}],
                {:data, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}
              ]},
             {:->, [generated: true],
              [
                [
                  {:when, [generated: true],
                   [
                     {:bin, [generated: true], PhoenixUndeadView.Template.Compiler.Escape},
                     {:is_binary,
                      [
                        generated: true,
                        context: PhoenixUndeadView.Template.Compiler.Escape,
                        import: Kernel
                      ], [{:bin, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}]}
                   ]}
                ],
                {{:., [generated: true],
                  [
                    {:__aliases__, [generated: true, alias: false], [:Plug, :HTML]},
                    :html_escape_to_iodata
                  ]}, [generated: true],
                 [{:bin, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]},
             {:->, [generated: true],
              [
                [{:other, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}],
                {{:., [line: nil],
                  [
                    {:__aliases__, [line: nil, alias: false], [:Phoenix, :HTML, :Safe]},
                    :to_iodata
                  ]}, [line: nil],
                 [{:other, [line: nil], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]}
           ]
         ]
       ]}
    ]},
   {:=, [],
    [
      {:f, [line: 4, counter: -576_460_752_303_416_088], PhoenixUndeadView.Template.Widgets.Form},
      {{:., [], [Phoenix.HTML.FormData, :to_form]}, [],
       [{:fetch_assign, [line: 4], [{:assigns, [line: 4, var: true], nil}, :changeset]}, []]}
    ]},
   {:=, [],
    [
      {:tmp_21_dynamic, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {:a, [line: 10], nil},
         [
           do: [
             {:->, [generated: true],
              [
                [safe: {:data, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}],
                {:data, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}
              ]},
             {:->, [generated: true],
              [
                [
                  {:when, [generated: true],
                   [
                     {:bin, [generated: true], PhoenixUndeadView.Template.Compiler.Escape},
                     {:is_binary,
                      [
                        generated: true,
                        context: PhoenixUndeadView.Template.Compiler.Escape,
                        import: Kernel
                      ], [{:bin, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}]}
                   ]}
                ],
                {{:., [generated: true],
                  [
                    {:__aliases__, [generated: true, alias: false], [:Plug, :HTML]},
                    :html_escape_to_iodata
                  ]}, [generated: true],
                 [{:bin, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]},
             {:->, [generated: true],
              [
                [{:other, [generated: true], PhoenixUndeadView.Template.Compiler.Escape}],
                {{:., [line: 10],
                  [{:__aliases__, [line: 10, alias: false], [:Phoenix, :HTML, :Safe]}, :to_iodata]},
                 [line: 10], [{:other, [line: 10], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]}
           ]
         ]
       ]}
    ]},
   {:safe,
    [
      {:tmp_3_dynamic, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:tmp_21_dynamic, [], PhoenixUndeadView.Template.Compiler.PreparedSegment}
    ]}
 ]}