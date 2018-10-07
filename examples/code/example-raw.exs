{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.Support, {a = 2, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\nBlah blah blah\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {form(fetch_assign(var!(assigns), :changeset), action, [], fn f ->
        {UndeadEngine.Segment.UndeadContainer,
         {[
            {UndeadEngine.Segment.Static, {"\n  ", []}},
            {UndeadEngine.Segment.Dynamic,
             {tag(:input,
                name: "user[name]",
                id: "user_name",
                value: fetch_assign(var!(assigns), :user).name()
              ), [line: 5]}},
            {UndeadEngine.Segment.Static, {"\n", []}}
          ], []}}
      end), [line: 4]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {a, [line: 8]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}