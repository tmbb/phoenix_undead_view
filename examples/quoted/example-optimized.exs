{UndeadEngine.Segment.UndeadContainer,
 {[
    {UndeadEngine.Segment.DynamicNoOutput,
     {{:=, [line: 1], [{:a, [line: 1], nil}, 2]}, [line: 1]}},
    {UndeadEngine.Segment.Static,
     {"\nBlah blah blah\n\n<input name=\"user[name]\" id=\"user_name\" value=\"", []}},
    {UndeadEngine.Segment.Dynamic,
     {{{:., [], [PhoenixUndeadView.Template.HTML, :html_escape]}, [],
       [
         {{:., [line: 4],
           [
             {{:., [line: 4], [Fixtures, :fetch_assign]}, [line: 4],
              [{:assigns, [line: 4, var: true], nil}, :user]},
             :name
           ]}, [line: 4], []}
       ]}, []}},
    {UndeadEngine.Segment.Static, {"\">\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {{:a, [line: 6], nil}, [line: 6]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}