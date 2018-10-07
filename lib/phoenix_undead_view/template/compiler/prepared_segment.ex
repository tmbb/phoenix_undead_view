defmodule PhoenixUndeadView.Template.Compiler.PreparedSegment do
  @moduledoc false
  require PhoenixUndeadView.Template.Segment, as: Segment

  defstruct segment: nil,
            appears_in_body?: nil,
            appears_in_result?: nil,
            variable: nil

  def new(fields) do
    struct(__MODULE__, fields)
  end

  # Body

  def appears_in_full_body?(segment) do
    case segment do
      Segment.static() -> false
      _ -> true
    end
  end

  def appears_in_dynamic_body?(segment) do
    case segment do
      Segment.static() -> false
      Segment.fixed() -> false
      _ -> true
    end
  end

  def appears_in_static_body?(segment) do
    case segment do
      Segment.fixed() -> true
      _ -> false
    end
  end

  # Results

  def appears_in_full_result?(segment) do
    case segment do
      Segment.support() -> false
      _ -> true
    end
  end

  def appears_in_dynamic_result?(segment) do
    case segment do
      Segment.dynamic() -> true
      _ -> false
    end
  end

  def appears_in_static_result?(segment) do
    case segment do
      Segment.static() -> true
      Segment.fixed() -> true
      _ -> false
    end
  end

  def variable_for(Segment.static(), _cursor, _index), do: nil

  def variable_for(Segment.support(), _cursor, _index), do: nil

  def variable_for(Segment.dynamic(), cursor, index) do
    var_name = String.to_atom("#{cursor}_#{index}_dynamic")
    Macro.var(var_name, __MODULE__)
  end

  def variable_for(Segment.fixed(), cursor, index) do
    var_name = String.to_atom("#{cursor}_#{index}_fixed")
    Macro.var(var_name, __MODULE__)
  end

  def variable_for(Segment.undead_container(), cursor, index) do
    var_name = String.to_atom("#{cursor}_#{index}_undead_container")
    Macro.var(var_name, __MODULE__)
  end

  def common(segment, cursor, index) do
    new(
      segment: segment,
      variable: variable_for(segment, cursor, index),
      cursor: append_to_cursor(cursor, index)
    )
  end

  @doc false
  def prepare_for_full(segment, cursor, index) do
    specific = %{
      appears_in_body?: appears_in_full_body?(segment),
      appears_in_result?: appears_in_full_result?(segment)
    }

    Map.merge(common(segment, cursor, index), specific)
  end

  @doc false
  def prepare_for_static(segment, cursor, index) do
    specific = %{
      appears_in_body?: appears_in_static_body?(segment),
      appears_in_result?: appears_in_static_result?(segment)
    }

    Map.merge(common(segment, cursor, index), specific)
  end

  @doc false
  def prepare_for_dynamic(segment, cursor, index) do
    specific = %{
      appears_in_body?: appears_in_dynamic_body?(segment),
      appears_in_result?: appears_in_dynamic_result?(segment)
    }

    Map.merge(common(segment, cursor, index), specific)
  end

  def prepare_all_for_full(segments, cursor) do
    segments
    |> Enum.with_index(1)
    |> Enum.map(fn {segment, index} -> prepare_for_full(segment, cursor, index) end)
  end

  def prepare_all_for_dynamic(segments, cursor) do
    segments
    |> Enum.with_index(1)
    |> Enum.map(fn {segment, index} -> prepare_for_dynamic(segment, cursor, index) end)
  end

  def prepare_all_for_static(segments, cursor) do
    segments
    |> Enum.with_index(1)
    |> Enum.map(fn {segment, index} -> prepare_for_static(segment, cursor, index) end)
  end

  defp append_to_cursor(cursor, index) do
    "#{cursor}_#{index}"
  end
end
