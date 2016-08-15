defmodule Todo.Server do
    use GenServer

    def start(name \\ "default") do
        GenServer.start(__MODULE__, name)
    end

    def add_entry(pid, entry) do
        GenServer.cast(pid, {:add_entry, entry})
    end

    def entries(pid, date) do
        GenServer.call(pid, {:entries, date})
    end

    def init(name) do
        {:ok, {name, Todo.Database.get(name) || Todo.List.new}}
    end

    def handle_cast({:add_entry, entry}, {name, todo_list}) do
        updated_todo_list = Todo.List.add_entry(todo_list, entry)
        Todo.Database.store(name, updated_todo_list)
        {:noreply, {name, updated_todo_list}}
    end

    def handle_call({:entries, date}, _, {name, todo_list}) do
        {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
    end
end