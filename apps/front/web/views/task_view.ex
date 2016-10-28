defmodule Front.TaskView do
  use Front.Web, :view

  def task_div(task) do
    content_tag :div, class: task_class(task), "data-id": task.id, onclick: "clickHandler(\"#{task.id}\")" do
      task.title
    end
  end

  defp task_class(%{done: true}),   do: "task done"
  defp task_class(%{done: false}),  do: "task"
end
