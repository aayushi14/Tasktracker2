defmodule Tasktracker.Hierarchy.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Hierarchy.Employee

  alias Tasktracker.Accounts.User

  schema "employees" do
    belongs_to :manager, User
    belongs_to :underling, User

    timestamps()
  end

  @doc false
  def changeset(%Employee{} = employee, attrs) do
    employee
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
  end
end
