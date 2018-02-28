defmodule Tasktracker.Hierarchy do
  @moduledoc """
  The Hierarchy context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Hierarchy.Employee

  @doc """
  Returns the list of employees.

  ## Examples

      iex> list_employees()
      [%Employee{}, ...]

  """
  def list_employees do
    Repo.all(Employee)
    |> Repo.preload(:manager)
    |> Repo.preload(:underling)
  end

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123)
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id) do
    Repo.get!(Employee, id)
    |> Repo.preload(:manager)
    |> Repo.preload(:underling)
  end

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{source: %Employee{}}

  """
  def change_employee(%Employee{} = employee) do
    Employee.changeset(employee, %{})
  end

  def get_managers() do
    Repo.all(from u in "users", where: u.isManager == "true", select: {u.name, u.id})
  end

  def get_managerIds() do
    Repo.all(from e in "employees", select: e.manager_id)
  end

  def get_assignedUnderlingIds() do
    Repo.all(from e in "employees", select: e.underling_id)
  end

  def get_assignedUnderlings() do
    assignedUnderlings = get_assignedUnderlingIds()
    Repo.all(from u in "users", where: u.id in ^assignedUnderlings, select: {u.name, u.id})
  end

  def get_unassignedUnderlings() do
    assignedUnderlings = get_assignedUnderlingIds()
    Repo.all(from u in "users", where: not u.id in ^assignedUnderlings, select: {u.name, u.id})
  end
end
