defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :isManager, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :isManager])
    |> validate_required([:email, :name, :isManager])
  end
end
