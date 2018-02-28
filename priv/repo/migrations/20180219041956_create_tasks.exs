defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :status, :boolean, default: false, null: false
      add :time_taken, :time, null: false
      add :assignedBy_id, references(:users, on_delete: :delete_all), null: false
      add :assignedTo_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:assignedBy_id])
    create index(:tasks, [:assignedTo_id])
  end
end
