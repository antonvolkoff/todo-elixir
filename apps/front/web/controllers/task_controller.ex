defmodule Front.TaskController do
  use Front.Web, :controller

  def index(conn, _) do
    conn
    |> assign(:tasks, Core.TaskManager.list())
    |> render("index.html")
  end
end
