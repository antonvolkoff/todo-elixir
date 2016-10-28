defmodule Core.Task do
  defstruct [id: nil, title: "", done: false]

  def build(title) do
    %Core.Task{id: Core.ID.generate(), title: title}
  end

  def toggle(%{done: true} = task),   do: uncomplete(task)
  def toggle(%{done: false} = task),  do: complete(task)

  def complete(task),   do: Map.put(task, :done, true)
  def uncomplete(task), do: Map.put(task, :done, false)
end
