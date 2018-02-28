defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def report(conn, _params) do
    tasks = Tasktracker.Jobs.list_tasks()
    render conn, "report.html", tasks: tasks
  end

  def log(conn, _params) do
    tasks = Tasktracker.Jobs.list_tasks()
    tasks = Enum.reverse(Tasktracker.Jobs.log_tasks_for(conn.assigns[:current_user]))
    changeset = Tasktracker.Jobs.change_task(%Tasktracker.Jobs.Task{})
    render conn, "log.html", tasks: tasks, changeset: changeset
  end
end
