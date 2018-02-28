defmodule Tasktracker.HierarchyTest do
  use Tasktracker.DataCase

  alias Tasktracker.Hierarchy

  describe "employees" do
    alias Tasktracker.Hierarchy.Employee

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Hierarchy.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Hierarchy.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Hierarchy.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Hierarchy.create_employee(@valid_attrs)
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hierarchy.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, employee} = Hierarchy.update_employee(employee, @update_attrs)
      assert %Employee{} = employee
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Hierarchy.update_employee(employee, @invalid_attrs)
      assert employee == Hierarchy.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Hierarchy.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Hierarchy.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Hierarchy.change_employee(employee)
    end
  end
end
