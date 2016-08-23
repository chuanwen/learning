defmodule Todo.Database do
    use GenServer

    def start_link(db_folder) do

        GenServer.start_link(__MODULE__, db_folder, name: :todo_database)
    end

    def stop() do
        GenServer.stop(:todo_database)
    end

    def store(key, data) do
        worker_pid = get_worker(key)
        Todo.DatabaseWorker.store(worker_pid, key, data)
    end

    def get(key) do
        worker_pid = get_worker(key)
        Todo.DatabaseWorker.get(worker_pid, key)
    end

    def delete(key) do
        worker_pid = get_worker(key)
        Todo.DatabaseWorker.delete(worker_pid, key)
    end

    def get_worker(key) do
        GenServer.call(:todo_database, {:get_worker, key})
    end

    def init(db_folder) do
        workers = 0..2 |> Enum.into(%{},
            fn(key) -> 
                {:ok, pid} = Todo.DatabaseWorker.start_link(db_folder)
                {key, pid}
            end)
        {:ok, workers}
    end

    def handle_call({:get_worker, key}, _, workers) do
        index = :erlang.phash2(key, 3)
        {:reply, workers[index], workers}
    end

end

defmodule Todo.DatabaseWorker do
    use GenServer

    def start_link(db_folder) do
        IO.puts "Starting database server."

        GenServer.start_link(__MODULE__, db_folder)
    end

    def stop(pid) do
        GenServer.stop(pid)
    end

    def store(pid, key, data) do
        GenServer.cast(pid, {:store, key, data})
    end

    def get(pid, key) do
        GenServer.call(pid, {:get, key})
    end

    def delete(pid, key) do
        GenServer.cast(pid, {:delete, key})
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