defmodule Todo.DatabaseTest do
    use ExUnit.Case
    doctest Todo.Server

    test "store, get and delete" do
        tmpdir = "./tmp" <> to_string(:random.uniform)
        Todo.Database.start(tmpdir)
        assert nil == Todo.Database.get("hello")
        Todo.Database.store("hello", 42)
        assert 42 == Todo.Database.get("hello")
        Todo.Database.delete("hello")
        assert nil == Todo.Database.get("hello")
        File.rmdir!(tmpdir)
    end
end