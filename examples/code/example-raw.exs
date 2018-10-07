{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.Support, {a = 2, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\nBlah blah blah\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {form(fetch_assign(var!(assigns), :changeset), action, [], fn f ->
        {UndeadEngine.Segment.UndeadContainer,
         {[
            {UndeadEngine.Segment.Static, {"\n  ", []}},
            {UndeadEngine.Segment.Dynamic, {text_input(f, :name), [line: 5]}},
            {UndeadEngine.Segment.Static, {"\n  ", []}},
            {UndeadEngine.Segment.Dynamic, {text_input(f, :surname), [line: 6]}},
            {UndeadEngine.Segment.Static, {"\n  ", []}},
            {UndeadEngine.Segment.Dynamic, {number_input(f, :age), [line: 7]}},
            {UndeadEngine.Segment.Static, {"\n", []}}
          ], []}}
      end), [line: 4]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {a, [line: 10]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}