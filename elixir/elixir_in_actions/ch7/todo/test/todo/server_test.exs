defmodule Todo.ServerTest do
    use ExUnit.Case
    doctest Todo.Server

    setup do
        tmpdir = "./tmp" <> to_string(:rand.uniform)
        Todo.Database.start_link(tmpdir)
        on_exit fn ->
            File.rm_rf!(tmpdir)
        end
    end

    test "add_entry and entries" do
        {:ok, pid} =  Todo.Server.start_link("Bob's list")
        Todo.Server.add_entry(pid, %{date: "8/1", title: "dental"})
        Todo.Server.add_entry(pid, %{date: "8/1", title: "hiking"})
        Todo.Server.add_entry(pid, %{date: "2016/08/12", title: "running"})
        assert Todo.Server.entries(pid, "8/2") == []
        [%{date: "2016/08/12", title: "running"}] = Todo.Server.entries(pid, "2016/08/12")
        assert length(Todo.Server.entries(pid, "8/1")) == 2
    end
end