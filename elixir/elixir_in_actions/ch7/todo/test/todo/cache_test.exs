defmodule Todo.CacheTest do
    use ExUnit.Case
    doctest Todo.Server

    test "server_process" do
        {:ok, cache_pid} = Todo.Cache.start
        server = Todo.Cache.server_process(cache_pid, "Bob's list")
        assert is_pid(server)
        assert server = Todo.Cache.server_process(cache_pid, "Bob's list")
    end
end