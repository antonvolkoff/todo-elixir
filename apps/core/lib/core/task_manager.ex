defmodule Core.TaskManager do
  use GenServer

  @name Core.TaskManager
  @default_state %{}

  ## Client ####################################################################

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [name: @name])
  end

  @doc """
    Retuns a list of task in todo list
  """
  def list,       do: GenServer.call(@name, :list)

  @doc """
    Adds task to the list

    Example:
      `Core.TaskManager.add(Core.Task.build("Test"))`
  """
  def add(task),  do: GenServer.cast(@name, {:add, task})

  def toggle(id), do: GenServer.call(@name, {:toggle, id})

  def remove(id), do: GenServer.call(@name, {:remove, id})

  def clear,      do: GenServer.call(@name, :clear)

  ## Server ####################################################################

  def init(:ok) do
    {:ok, @default_state}
  end

  def handle_cast({:add, task}, state) do
    state = Map.put(state, task.id, task)
    {:noreply, state}
  end

  def handle_call({:toggle, id}, _, state) do
    state =
      case Map.fetch(state, id) do
        {:ok, task} -> Map.put(state, task.id, Core.Task.toggle(task))
        {:error}    -> state
      end

    {:reply, :ok, state}
  end

  def handle_call(:clear, _from, _state) do
    {:reply, :ok, @default_state}
  end

  def handle_call(:list, _from, state) do
    {:reply, Map.values(state), state}
  end

  def handle_call({:remove, id}, _, state) do
    state = Map.delete(state, id)
    {:reply, :ok, state}
  end
end
