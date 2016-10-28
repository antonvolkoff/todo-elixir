defmodule Front.TaskChannel do
  use Front.Web, :channel

  alias Core.{TaskManager, Task}

  def join("task:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("task::create", %{"title" => title}, socket) do
    Task.build(title) |> TaskManager.add()
    broadcast_reload(socket)
    {:noreply, socket}
  end

  def handle_in("task::toggle", %{"id" => id}, socket) do
    TaskManager.toggle(id)
    broadcast_reload(socket)
    {:noreply, socket}
  end

  def handle_in("task::remove", %{"id" => id}, socket) do
    TaskManager.remove(id)
    broadcast_reload(socket)
    {:noreply, socket}
  end

  defp authorized?(_payload), do: true

  defp broadcast_reload(socket), do: broadcast(socket, "task/reload", task_list)

  defp task_list do
    %{html: Phoenix.View.render_to_string(Front.TaskView, "list.html", tasks: tasks)}
  end

  defp tasks, do: TaskManager.list()
end
