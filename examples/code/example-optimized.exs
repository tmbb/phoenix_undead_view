{UndeadEngine.Segment.UndeadTemplate,
 {[
    {UndeadEngine.Segment.DynamicNoOutput, {a = 2, [line: 1]}},
    {UndeadEngine.Segment.Static,
     {"\nBlah blah blah\n\n<input name=\"user[name]\" id=\"user_name\" value=\"", []}},
    {UndeadEngine.Segment.Dynamic,
     {PhoenixUndeadView.Template.HTML.html_escape(Fixtures.fetch_assign(assigns, :user).name()),
      []}},
    {UndeadEngine.Segment.Static, {"\">\n\n", []}},
    {UndeadEngine.Segment.Dynamic, {a, [line: 6]}},
    {UndeadEngine.Segment.Static, {"\n\nBlah blah\n", []}}
  ], []}}