defmodule Tasktracker.Jobs.Time do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Jobs.Time


  schema "timeblocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :task, Tasktracker.Jobs.Task

    timestamps()
  end

  @doc false
  def changeset(%Time{} = time, attrs) do
    time
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end, :task_id])
  end
end
