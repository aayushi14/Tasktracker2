defmodule Tasktracker.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :manager_id, references(:users, on_delete: :delete_all), null: false
      add :underling_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:employees, [:manager_id])
    create index(:employees, [:underling_id])
  end
end
