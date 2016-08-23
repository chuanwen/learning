defmodule Todo.CacheTest do
    use ExUnit.Case
    doctest Todo.Server

    test "server_process of Todo.Cache" do
        {:ok, _} = Todo.Cache.start_link
        server = Todo.Cache.server_process("Bob's list")
        assert is_pid(server)
        assert server == Todo.Cache.server_process("Bob's list")
    end
end