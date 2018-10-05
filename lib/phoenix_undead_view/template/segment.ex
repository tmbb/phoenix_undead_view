defmodule PhoenixUndeadView.Template.Segment do
  def undead_containter(contents, meta \\ []) do
    {UndeadEngine.Segment.UndeadContainer, {contents, meta}}
  end

  def static(contents, meta \\ []) do
    {UndeadEngine.Segment.Static, {contents, meta}}
  end

  def dynamic(contents, meta \\ []) do
    {UndeadEngine.Segment.Dynamic, {contents, meta}}
  end

  def dynamic_no_output(contents, meta \\ []) do
    {UndeadEngine.Segment.DynamicNoOutput, {contents, meta}}
  end

  def fixed(contents, meta \\ []) do
    {UndeadEngine.Segment.Fixed, {contents, meta}}
  end
end
