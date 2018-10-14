{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.Support, {a = 2, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\n", []}},
    {UndeadEngine.Segment.Support, {fixed = a, [line: 2]}},
    {UndeadEngine.Segment.Static, {"\nStatic part #1\n\n", []}},
    {UndeadEngine.Segment.Fixedw, {fixed, [line: 5]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {if(a > 1) do
        {UndeadEngine.Segment.UndeadContainer,
         {[
            {UndeadEngine.Segment.Static, {"\n  ", []}},
            {UndeadEngine.Segment.Dynamic, {a, [line: 8]}},
            {UndeadEngine.Segment.Static, {"\n", []}}
          ], []}}
      else
        {UndeadEngine.Segment.UndeadContainer,
         {[{UndeadEngine.Segment.Static, {"\n  Nope\n", []}}], []}}
      end, [line: 7]}},
    {UndeadEngine.Segment.Static, {"\n\nStatic part #2\n", []}}
  ], []}}