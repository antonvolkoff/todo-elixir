defmodule Core.ID  do
  use GenServer

  @name Core.ID

  ## Client ####################################################################

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [name: @name])
  end

  def generate do
    GenServer.call(@name, :generate)
  end

  ## Server ####################################################################

  def init(:ok) do
    {:ok, 0}
  end

  def handle_call(:generate, _, state) do
    {:reply, Integer.to_string(state), state + 1}
  end
end
