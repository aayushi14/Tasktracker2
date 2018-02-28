defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Jobs
  alias Tasktracker.Jobs.Task
  alias Tasktracker.Accounts
  alias Tasktracker.Jobs.Time

  def index(conn, _params) do
    tasks = Jobs.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Jobs.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, users: @users_list)
  end

  def create(conn, %{"task" => task_params}) do
  {minute_value, _ } = Integer.parse(task_params["time_taken"]["minute"])
  remainder = rem minute_value, 15
    if (remainder != 0) do
      conn
      |> put_flash(:error, "Time must be in 15 minute increments")
      |> redirect(to: task_path(conn, :new))
    else
      case Jobs.create_task(task_params) do
        {:ok, task} ->
          conn
          |> put_flash(:info, "Task created successfully.")
          |> redirect(to: task_path(conn, :show, task))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    task = Jobs.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Jobs.get_task!(id)
    changeset = Jobs.change_task(task)
    timeblocks = Time.get_time()
    render(conn, "edit.html", task: task, changeset: changeset, users: @users_list, timeblocks: timeblocks)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Jobs.get_task!(id)

    remainder = 0
      if (remainder != 0) do
        conn
        |> put_flash(:error, "Time must be in 15 minute increments")
        |> redirect(to: task_path(conn, :edit, task))
      else
      case Jobs.update_task(task, task_params) do
        {:ok, task} ->
          conn
          |> put_flash(:info, "Task updated successfully.")
          |> redirect(to: task_path(conn, :show, task))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", task: task, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Jobs.get_task!(id)
    {:ok, _task} = Jobs.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
