defmodule Todo.DatabaseTest do
    use ExUnit.Case
    doctest Todo.Server

    setup do
        tmpdir = "./tmp" <> to_string(:rand.uniform)
        Todo.Database.start_link(tmpdir)
        on_exit fn ->
            File.rm_rf!(tmpdir)
        end
    end

    test "store, get and delete" do
        assert nil == Todo.Database.get("hello")
        Todo.Database.store("hello", 42)
        assert 42 == Todo.Database.get("hello")
        Todo.Database.delete("hello")
        assert nil == Todo.Database.get("hello")
    end
end