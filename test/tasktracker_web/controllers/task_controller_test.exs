defmodule TasktrackerWeb.TaskControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Jobs

  @create_attrs %{description: "some description", status: true, time_taken: ~T[14:00:00.000000], title: "some title"}
  @update_attrs %{description: "some updated description", status: false, time_taken: ~T[15:01:01.000000], title: "some updated title"}
  @invalid_attrs %{description: nil, status: nil, time_taken: nil, title: nil}

  def fixture(:task) do
    {:ok, task} = Jobs.create_task(@create_attrs)
    task
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get conn, task_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Tasks"
    end
  end

  describe "new task" do
    test "renders form", %{conn: conn} do
      conn = get conn, task_path(conn, :new)
      assert html_response(conn, 200) =~ "New Task"
    end
  end

  describe "create task" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, task_path(conn, :create), task: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == task_path(conn, :show, id)

      conn = get conn, task_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Task"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_path(conn, :create), task: @invalid_attrs
      assert html_response(conn, 200) =~ "New Task"
    end
  end

  describe "edit task" do
    setup [:create_task]

    test "renders form for editing chosen task", %{conn: conn, task: task} do
      conn = get conn, task_path(conn, :edit, task)
      assert html_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "update task" do
    setup [:create_task]

    test "redirects when data is valid", %{conn: conn, task: task} do
      conn = put conn, task_path(conn, :update, task), task: @update_attrs
      assert redirected_to(conn) == task_path(conn, :show, task)

      conn = get conn, task_path(conn, :show, task)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put conn, task_path(conn, :update, task), task: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete conn, task_path(conn, :delete, task)
      assert redirected_to(conn) == task_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, task_path(conn, :show, task)
      end
    end
  end

  defp create_task(_) do
    task = fixture(:task)
    {:ok, task: task}
  end
end
