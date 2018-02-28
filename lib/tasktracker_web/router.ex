defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :get_users_list
    plug :get_managers_list
    plug :get_managerIds_list
    plug :get_assignedUnderlingIds_list
    plug :get_assignedUnderlings_list
    plug :get_unassignedUnderlings_list
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  def get_current_user(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Tasktracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  def get_users_list(conn, _params) do
    users = Tasktracker.Accounts.get_users()
    assign(conn, :users_list, users)
  end

  def get_managers_list(conn, _params) do
    managers = Tasktracker.Hierarchy.get_managers()
    assign(conn, :managers_list, managers)
  end

  def get_managerIds_list(conn, _params) do
    managerIds = Tasktracker.Hierarchy.get_managerIds()
    assign(conn, :managerIds_list, managerIds)
  end

  def get_assignedUnderlingIds_list(conn, _params) do
    assignedUnderlingIds = Tasktracker.Hierarchy.get_assignedUnderlingIds()
    assign(conn, :assignedUnderlingIds_list, assignedUnderlingIds)
  end

  def get_assignedUnderlings_list(conn, _params) do
    assignedUnderlings = Tasktracker.Hierarchy.get_assignedUnderlings()
    assign(conn, :assignedUnderlings_list, assignedUnderlings)
  end

  def get_unassignedUnderlings_list(conn, _params) do
    unassignedUnderlings = Tasktracker.Hierarchy.get_unassignedUnderlings()
    assign(conn, :unassignedUnderlings_list, unassignedUnderlings)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasktrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/log", PageController, :log
    get "/report", PageController, :report

    resources "/users", UserController
    resources "/tasks", TaskController
    resources "/employees", EmployeeController

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TasktrackerWeb do
    pipe_through :api
    resources "/timeblocks", TimeController, except: [:new, :edit]
  end
end
