defmodule Todo.Database do
    use GenServer

    def start(db_folder) do
        GenServer.start(__MODULE__, db_folder, name: :todo_database)
    end

    def stop() do
        GenServer.stop(:todo_database)
    end

    def store(key, data) do
        GenServer.cast(:todo_database, {:store, key, data})
    end

    def get(key) do
        GenServer.call(:todo_database, {:get, key})
    end

    def delete(key) do
        GenServer.cast(:todo_database, {:delete, key})
    end

    def init(db_folder) do
        File.mkdir_p(db_folder)
        {:ok, db_folder}
    end

    def handle_cast({:store, key, data}, db_folder) do
        File.write!(Path.join(db_folder, key), :erlang.term_to_binary(data))
        {:noreply, db_folder}
    end

    def handle_cast({:delete, key}, db_folder) do
        File.rm!(Path.join(db_folder, key))
        {:noreply, db_folder}
    end

    def handle_call({:get, key}, _, db_folder) do
        data = case File.read(Path.join(db_folder, key)) do
            {:ok, content} -> :erlang.binary_to_term(content)
            _ -> nil
        end
        {:reply, data, db_folder}
    end

end