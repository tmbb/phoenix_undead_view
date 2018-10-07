{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.Support, {{:=, [line: 1], [{:a, [line: 1], nil}, 2]}, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\nBlah blah blah\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {{:form, [line: 4],
       [
         {:fetch_assign, [line: 4],
          [
            {:var!, [line: 4, context: PhoenixUndeadView.Template.UndeadEngine, import: Kernel],
             [{:assigns, [line: 4], PhoenixUndeadView.Template.UndeadEngine}]},
            :changeset
          ]},
         {:action, [line: 4], nil},
         [],
         {:fn, [line: 4],
          [
            {:->, [line: 4],
             [
               [{:f, [line: 4], nil}],
               {UndeadEngine.Segment.UndeadContainer,
                {[
                   {UndeadEngine.Segment.Static, {"\n  ", []}},
                   {UndeadEngine.Segment.Dynamic,
                    {{:tag, [line: 5],
                      [
                        :input,
                        [
                          name: "user[name]",
                          id: "user_name",
                          value:
                            {{:., [line: 5],
                              [
                                {:fetch_assign, [line: 5],
                                 [
                                   {:var!,
                                    [
                                      line: 5,
                                      context: PhoenixUndeadView.Template.UndeadEngine,
                                      import: Kernel
                                    ],
                                    [
                                      {:assigns, [line: 5],
                                       PhoenixUndeadView.Template.UndeadEngine}
                                    ]},
                                   :user
                                 ]},
                                :name
                              ]}, [line: 5], []}
                        ]
                      ]}, [line: 5]}},
                   {UndeadEngine.Segment.Static, {"\n", []}}
                 ], []}}
             ]}
          ]}
       ]}, [line: 4]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {{:a, [line: 8], nil}, [line: 8]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}