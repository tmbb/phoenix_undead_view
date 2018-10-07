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
                    {{:text_input, [line: 5], [{:f, [line: 5], nil}, :name]}, [line: 5]}},
                   {UndeadEngine.Segment.Static, {"\n  ", []}},
                   {UndeadEngine.Segment.Dynamic,
                    {{:text_input, [line: 6], [{:f, [line: 6], nil}, :surname]}, [line: 6]}},
                   {UndeadEngine.Segment.Static, {"\n  ", []}},
                   {UndeadEngine.Segment.Dynamic,
                    {{:number_input, [line: 7], [{:f, [line: 7], nil}, :age]}, [line: 7]}},
                   {UndeadEngine.Segment.Static, {"\n", []}}
                 ], []}}
             ]}
          ]}
       ]}, [line: 4]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {{:a, [line: 10], nil}, [line: 10]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}