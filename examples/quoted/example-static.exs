{:__block__, [],
 [
   {:=, [],
    [
      {:tmp_5, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {{:., [], [Plug.CSRFProtection, :get_csrf_token_for]}, [], [{:action, [line: 4], nil}]},
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
   {:safe,
    [
      "\nBlah blah blah\n\n<form action=\"",
      "\"><input name=\"_csrf_token\" type=\"hidden\" value=\"",
      {:tmp_5, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      "\">",
      "\n  <input name=\"user[name]\" id=\"user_name\" value=\"",
      "\">\n</form>\n\n",
      "\n\nBlah blah\n"
    ]}
 ]}