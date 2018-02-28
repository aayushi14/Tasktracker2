defmodule TasktrackerWeb.EmployeeController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Hierarchy
  alias Tasktracker.Hierarchy.Employee

  def index(conn, _params) do
    employees = Hierarchy.list_employees()
    render(conn, "index.html", employees: employees)
  end

  def new(conn, _params) do
    changeset = Hierarchy.change_employee(%Employee{})
    render(conn, "new.html", changeset: changeset, managers: @managers_list, underlings: @underlings_list)
  end

  def create(conn, %{"employee" => employee_params}) do
    case Hierarchy.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee created successfully.")
        |> redirect(to: employee_path(conn, :show, employee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Hierarchy.get_employee!(id)
    render(conn, "show.html", employee: employee)
  end

  def edit(conn, %{"id" => id}) do
    employee = Hierarchy.get_employee!(id)
    changeset = Hierarchy.change_employee(employee)
    render(conn, "edit.html", employee: employee, changeset: changeset, managers: @managers_list, underlings: @underlings_list)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Hierarchy.get_employee!(id)

    case Hierarchy.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee updated successfully.")
        |> redirect(to: employee_path(conn, :show, employee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Hierarchy.get_employee!(id)
    {:ok, _employee} = Hierarchy.delete_employee(employee)

    conn
    |> put_flash(:info, "Relation deleted successfully.")
    |> redirect(to: employee_path(conn, :index))
  end
end
