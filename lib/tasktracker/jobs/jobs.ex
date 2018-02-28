defmodule Tasktracker.Jobs do
  @moduledoc """
  The Jobs context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Jobs.Task
  alias Tasktracker.Jobs.Time

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:assignedBy)
    |> Repo.preload(:assignedTo)
  end

  def log_tasks_for(user) do
    user = Repo.preload(user, :managers)
    underling_ids = Enum.map(user.managers, &(&1.id))

    Repo.all(Task)
    |> Enum.filter(&(Enum.member?(underling_ids, &1.user_id)))
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:assignedBy)
    |> Repo.preload(:assignedTo)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasktracker.Jobs.Time

  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%Time{}, ...]

  """
  def list_timeblocks do
    Repo.all(Time)
  end

  @doc """
  Gets a single time.

  Raises `Ecto.NoResultsError` if the Time does not exist.

  ## Examples

      iex> get_time!(123)
      %Time{}

      iex> get_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time!(id), do: Repo.get!(Time, id)

  @doc """
  Creates a time.

  ## Examples

      iex> create_time(%{field: value})
      {:ok, %Time{}}

      iex> create_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time(attrs \\ %{}) do
    %Time{}
    |> Time.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time.

  ## Examples

      iex> update_time(time, %{field: new_value})
      {:ok, %Time{}}

      iex> update_time(time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time(%Time{} = time, attrs) do
    time
    |> Time.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Time.

  ## Examples

      iex> delete_time(time)
      {:ok, %Time{}}

      iex> delete_time(time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time(%Time{} = time) do
    Repo.delete(time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time changes.

  ## Examples

      iex> change_time(time)
      %Ecto.Changeset{source: %Time{}}

  """
  def change_time(%Time{} = time) do
    Time.changeset(time, %{})
  end

  def get_time() do
    Repo.all(from t in "timeblocks", select: {t.start, t.end})
  end

  def getTaskTime(id) do
    Repo.all(from t in "timeblocks", where: t.task_id == ^id, select: {t.start, t.end})
  end
end
