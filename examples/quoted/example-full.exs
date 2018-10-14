{:__block__, [],
 [
   {:=, [], [{:_, [], PhoenixUndeadView.Template.Compiler}, {:assigns, [], nil}]},
   {:=, [],
    [
      {:element_id, [], PhoenixUndeadView.Template.Compiler},
      {{:., [], [{:__aliases__, [alias: false], [:Integer]}, :to_string]}, [],
       [{{:., [], [:rand, :uniform]}, [], [4_294_967_296]}, 32]}
    ]},
   {:=, [line: 1], [{:a, [line: 1], nil}, 2]},
   {:=, [line: 2], [{:fixed, [line: 2], nil}, {:a, [line: 2], nil}]},
   {:=, [],
    [
      {:tmp_4_fixed, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {:fixed, [line: 5], nil},
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
                {{:., [line: 5],
                  [{:__aliases__, [line: 5, alias: false], [:Phoenix, :HTML, :Safe]}, :to_iodata]},
                 [line: 5], [{:other, [line: 5], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]}
           ]
         ]
       ]}
    ]},
   {:=, [],
    [
      {:tmp_6_dynamic, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      {:case, [generated: true],
       [
         {:case, [optimize_boolean: true],
          [
            {:>, [line: 7], [{:a, [line: 7], nil}, 1]},
            [
              do: [
                {:->, [],
                 [
                   [
                     {:when, [],
                      [
                        {:x, [counter: -576_460_752_303_423_481], Kernel},
                        {{:., [], [:erlang, :orelse]}, [],
                         [
                           {{:., [], [:erlang, :"=:="]}, [],
                            [{:x, [counter: -576_460_752_303_423_481], Kernel}, nil]},
                           {{:., [], [:erlang, :"=:="]}, [],
                            [{:x, [counter: -576_460_752_303_423_481], Kernel}, false]}
                         ]}
                      ]}
                   ],
                   {:__block__, [], [safe: ["\n  Nope\n"]]}
                 ]},
                {:->, [],
                 [
                   [{:_, [], Kernel}],
                   {:__block__, [],
                    [
                      {:=, [],
                       [
                         {:tmp_2_2_dynamic, [],
                          PhoenixUndeadView.Template.Compiler.PreparedSegment},
                         {:case, [generated: true],
                          [
                            {:a, [line: 8], nil},
                            [
                              do: [
                                {:->, [generated: true],
                                 [
                                   [
                                     safe:
                                       {:data, [generated: true],
                                        PhoenixUndeadView.Template.Compiler.Escape}
                                   ],
                                   {:data, [generated: true],
                                    PhoenixUndeadView.Template.Compiler.Escape}
                                 ]},
                                {:->, [generated: true],
                                 [
                                   [
                                     {:when, [generated: true],
                                      [
                                        {:bin, [generated: true],
                                         PhoenixUndeadView.Template.Compiler.Escape},
                                        {:is_binary,
                                         [
                                           generated: true,
                                           context: PhoenixUndeadView.Template.Compiler.Escape,
                                           import: Kernel
                                         ],
                                         [
                                           {:bin, [generated: true],
                                            PhoenixUndeadView.Template.Compiler.Escape}
                                         ]}
                                      ]}
                                   ],
                                   {{:., [generated: true],
                                     [
                                       {:__aliases__, [generated: true, alias: false],
                                        [:Plug, :HTML]},
                                       :html_escape_to_iodata
                                     ]}, [generated: true],
                                    [
                                      {:bin, [generated: true],
                                       PhoenixUndeadView.Template.Compiler.Escape}
                                    ]}
                                 ]},
                                {:->, [generated: true],
                                 [
                                   [
                                     {:other, [generated: true],
                                      PhoenixUndeadView.Template.Compiler.Escape}
                                   ],
                                   {{:., [line: 8],
                                     [
                                       {:__aliases__, [line: 8, alias: false],
                                        [:Phoenix, :HTML, :Safe]},
                                       :to_iodata
                                     ]}, [line: 8],
                                    [
                                      {:other, [line: 8],
                                       PhoenixUndeadView.Template.Compiler.Escape}
                                    ]}
                                 ]}
                              ]
                            ]
                          ]}
                       ]},
                      {:safe,
                       [
                         "\n  ",
                         {:tmp_2_2_dynamic, [],
                          PhoenixUndeadView.Template.Compiler.PreparedSegment},
                         "\n"
                       ]}
                    ]}
                 ]}
              ]
            ]
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
                {{:., [line: 7],
                  [{:__aliases__, [line: 7, alias: false], [:Phoenix, :HTML, :Safe]}, :to_iodata]},
                 [line: 7], [{:other, [line: 7], PhoenixUndeadView.Template.Compiler.Escape}]}
              ]}
           ]
         ]
       ]}
    ]},
   {:safe,
    [
      "<span id=\"",
      {:element_id, [], PhoenixUndeadView.Template.Compiler},
      "\">\n\nStatic part #1\n\n",
      {:tmp_4_fixed, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      "\n\n",
      {:tmp_6_dynamic, [], PhoenixUndeadView.Template.Compiler.PreparedSegment},
      "\n\nStatic part #2\n</span>\n\n<script type=\"application/json\" undead-id=\"",
      {:element_id, [], PhoenixUndeadView.Template.Compiler},
      "\">\n[\n  \"\",\n  \"\\n\\nStatic part #1\\n\\n",
      {{:., [], [{:__aliases__, [alias: false], [:Phoenix, :HTML]}, :escape_javascript]}, [],
       [{:tmp_4_fixed, [], PhoenixUndeadView.Template.Compiler.PreparedSegment}]},
      "\\n\\n\",\n  \"\\n\\nStatic part #2\\n\"\n]\n</script>"
    ]}
 ]}