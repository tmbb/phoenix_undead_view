{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.Support, {{:=, [line: 1], [{:a, [line: 1], nil}, 2]}, [line: 1]}},
    {UndeadEngine.Segment.Static, {"\n", []}},
    {UndeadEngine.Segment.Support,
     {{:=, [line: 2], [{:fixed, [line: 2], nil}, {:a, [line: 2], nil}]}, [line: 2]}},
    {UndeadEngine.Segment.Static, {"\nStatic part #1\n\n", []}},
    {UndeadEngine.Segment.Fixedw, {{:fixed, [line: 5], nil}, [line: 5]}},
    {UndeadEngine.Segment.Static, {"\n\n", []}},
    {UndeadEngine.Segment.Dynamic,
     {{:if, [line: 7],
       [
         {:>, [line: 7], [{:a, [line: 7], nil}, 1]},
         [
           do:
             {UndeadEngine.Segment.UndeadContainer,
              {[
                 {UndeadEngine.Segment.Static, {"\n  ", []}},
                 {UndeadEngine.Segment.Dynamic, {{:a, [line: 8], nil}, [line: 8]}},
                 {UndeadEngine.Segment.Static, {"\n", []}}
               ], []}},
           else:
             {UndeadEngine.Segment.UndeadContainer,
              {[{UndeadEngine.Segment.Static, {"\n  Nope\n", []}}], []}}
         ]
       ]}, [line: 7]}},
    {UndeadEngine.Segment.Static, {"\n\nStatic part #2\n", []}}
  ], []}}