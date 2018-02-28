defmodule Tasktracker.Jobs.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Jobs.Task

  schema "tasks" do
    field :description, :string
    field :status, :boolean, default: false
    field :time_taken, :time
    field :title, :string
    belongs_to :assignedBy, Tasktracker.Accounts.User
    belongs_to :assignedTo, Tasktracker.Accounts.User

    has_one :task_times, Tasktracker.Jobs.Time, foreign_key: :task_id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :status, :time_taken, :assignedBy_id, :assignedTo_id])
    |> validate_required([:title, :description, :status, :time_taken, :assignedBy_id, :assignedTo_id])
  end
end
