{:__block__, [],
 [
   {:=, [line: 1], [{:a, [line: 1], nil}, 2]},
   {:=, [],
    [
      {:tmp_3, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {{:., [], [PhoenixUndeadView.Template.HTML, :html_escape]}, [],
          [
            {{:., [line: 4],
              [{:fetch_assign, [line: 4], [{:assigns, [line: 4, var: true], nil}, :user]}, :name]},
             [line: 4], []}
          ]},
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
      {:tmp_5, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {:a, [line: 6], nil},
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
                {{:., [line: 6],
                  [{:__aliases__, [line: 6, alias: false], [:Phoenix, :HTML, :Safe]}, :to_iodata]},
                 [line: 6], [{:other, [line: 6], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]}
           ]
         ]
       ]}
    ]},
   {:safe,
    [
      {:tmp_3, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:tmp_5, [], PhoenixUndeadView.Template.Compiler.PreparedSegment}
    ]}
 ]}