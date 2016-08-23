defmodule Todo.ListTest do
  use ExUnit.Case
  doctest Todo.List

  setup do
    {:ok, todo_list: Todo.List.new}
  end
  test "add_entry and entries", state do
    todo_list = state[:todo_list]
    new_todo_list = todo_list 
      |> Todo.List.add_entry(%{date: "1/1", title: "dental"})
      |> Todo.List.add_entry(%{date: "1/1", title: "hiking"})
      |> Todo.List.add_entry(%{date: "2016/08/12", title: "running"})
    assert Todo.List.entries(new_todo_list, "1/3") == []
    [%{date: "2016/08/12", title: "running"}] = Todo.List.entries(new_todo_list, "2016/08/12")
    assert length(Todo.List.entries(new_todo_list, "1/1")) == 2
  end
end
