{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.Support, {{:=, [line: 1], [{:a, [line: 1], nil}, 2]}, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\nBlah blah blah\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {{:tag, [line: 4],
       [
         :input,
         [
           name: "user[name]",
           id: "user_name",
           value:
             {{:., [line: 4],
               [
                 {:fetch_assign, [line: 4],
                  [
                    {:var!,
                     [line: 4, context: PhoenixUndeadView.Template.UndeadEngine, import: Kernel],
                     [{:assigns, [line: 4], PhoenixUndeadView.Template.UndeadEngine}]},
                    :user
                  ]},
                 :name
               ]}, [line: 4], []}
         ]
       ]}, [line: 4]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {{:a, [line: 6], nil}, [line: 6]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}