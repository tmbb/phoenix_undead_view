{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.DynamicNoOutput, {a = 2, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\nBlah blah blah\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {tag(:input,
        name: "user[name]",
        id: "user_name",
        value: fetch_assign(var!(assigns), :user).name()
      ), [line: 4]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {a, [line: 6]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}