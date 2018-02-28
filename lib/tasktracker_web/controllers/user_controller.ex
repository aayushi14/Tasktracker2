defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    email_id = user_params["email"]
    email_list = Accounts.get_email()
    if (Enum.member?(email_list, email_id)) do
      conn
      |> put_flash(:error, "Email-id is already registered")
      |> redirect(to: user_path(conn, :new))
    else
      case Accounts.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: user_path(conn, :show, user))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    manager = Accounts.get_myManager(user.id)
    underlings = Accounts.get_myUnderlingsNames(user.id)
    render(conn, "show.html", user: user, manager: manager, underlings: underlings)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    email_id = user_params["email"]
    email_list = Accounts.get_email()
    if (Enum.member?(email_list, email_id)) do
      conn
      |> put_flash(:error, "Email-id is already registered")
      |> redirect(to: user_path(conn, :edit, user))
    else
      case Accounts.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: user_path(conn, :show, user))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    cur_user = get_session(conn, :user_id)
    if (cur_user == user.id) do
      conn
      |> put_flash(:error, "Request another manager to delete you.")
      |> redirect(to: user_path(conn, :index))
    else
      {:ok, _user} = Accounts.delete_user(user)

      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: user_path(conn, :index))
    end
  end
end
