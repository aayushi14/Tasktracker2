defmodule Tasktracker.JobsTest do
  use Tasktracker.DataCase

  alias Tasktracker.Jobs

  describe "tasks" do
    alias Tasktracker.Jobs.Task

    @valid_attrs %{description: "some description", status: true, time_taken: ~N[2010-04-17 14:00:00.000000], title: "some title"}
    @update_attrs %{description: "some updated description", status: false, time_taken: ~N[2011-05-18 15:01:01.000000], title: "some updated title"}
    @invalid_attrs %{description: nil, status: nil, time_taken: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Jobs.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Jobs.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Jobs.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.status == true
      assert task.time_taken == ~N[2010-04-17 14:00:00.000000]
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Jobs.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.status == false
      assert task.time_taken == ~N[2011-05-18 15:01:01.000000]
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_task(task, @invalid_attrs)
      assert task == Jobs.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Jobs.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Jobs.change_task(task)
    end
  end

  describe "tasks" do
    alias Tasktracker.Jobs.Task

    @valid_attrs %{description: "some description", status: true, time_taken: ~T[14:00:00.000000], title: "some title"}
    @update_attrs %{description: "some updated description", status: false, time_taken: ~T[15:01:01.000000], title: "some updated title"}
    @invalid_attrs %{description: nil, status: nil, time_taken: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Jobs.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Jobs.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Jobs.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.status == true
      assert task.time_taken == ~T[14:00:00.000000]
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Jobs.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.status == false
      assert task.time_taken == ~T[15:01:01.000000]
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_task(task, @invalid_attrs)
      assert task == Jobs.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Jobs.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Jobs.change_task(task)
    end
  end

  describe "timeblocks" do
    alias Tasktracker.Jobs.Time

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def time_fixture(attrs \\ %{}) do
      {:ok, time} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_time()

      time
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time = time_fixture()
      assert Jobs.list_timeblocks() == [time]
    end

    test "get_time!/1 returns the time with given id" do
      time = time_fixture()
      assert Jobs.get_time!(time.id) == time
    end

    test "create_time/1 with valid data creates a time" do
      assert {:ok, %Time{} = time} = Jobs.create_time(@valid_attrs)
    end

    test "create_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_time(@invalid_attrs)
    end

    test "update_time/2 with valid data updates the time" do
      time = time_fixture()
      assert {:ok, time} = Jobs.update_time(time, @update_attrs)
      assert %Time{} = time
    end

    test "update_time/2 with invalid data returns error changeset" do
      time = time_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_time(time, @invalid_attrs)
      assert time == Jobs.get_time!(time.id)
    end

    test "delete_time/1 deletes the time" do
      time = time_fixture()
      assert {:ok, %Time{}} = Jobs.delete_time(time)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_time!(time.id) end
    end

    test "change_time/1 returns a time changeset" do
      time = time_fixture()
      assert %Ecto.Changeset{} = Jobs.change_time(time)
    end
  end

  describe "timeblocks" do
    alias Tasktracker.Jobs.Time

    @valid_attrs %{end: ~N[2010-04-17 14:00:00.000000], start: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01.000000], start: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def time_fixture(attrs \\ %{}) do
      {:ok, time} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_time()

      time
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time = time_fixture()
      assert Jobs.list_timeblocks() == [time]
    end

    test "get_time!/1 returns the time with given id" do
      time = time_fixture()
      assert Jobs.get_time!(time.id) == time
    end

    test "create_time/1 with valid data creates a time" do
      assert {:ok, %Time{} = time} = Jobs.create_time(@valid_attrs)
      assert time.end == ~N[2010-04-17 14:00:00.000000]
      assert time.start == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_time(@invalid_attrs)
    end

    test "update_time/2 with valid data updates the time" do
      time = time_fixture()
      assert {:ok, time} = Jobs.update_time(time, @update_attrs)
      assert %Time{} = time
      assert time.end == ~N[2011-05-18 15:01:01.000000]
      assert time.start == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time/2 with invalid data returns error changeset" do
      time = time_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_time(time, @invalid_attrs)
      assert time == Jobs.get_time!(time.id)
    end

    test "delete_time/1 deletes the time" do
      time = time_fixture()
      assert {:ok, %Time{}} = Jobs.delete_time(time)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_time!(time.id) end
    end

    test "change_time/1 returns a time changeset" do
      time = time_fixture()
      assert %Ecto.Changeset{} = Jobs.change_time(time)
    end
  end
end
