{application,tasktracker,
             [{applications,[kernel,stdlib,elixir,logger,runtime_tools,
                             gettext,phoenix_pubsub,cowboy,phoenix_html,
                             phoenix,phoenix_live_reload,postgrex,
                             phoenix_ecto]},
              {description,"tasktracker"},
              {modules,['Elixir.Tasktracker','Elixir.Tasktracker.Accounts',
                        'Elixir.Tasktracker.Accounts.User',
                        'Elixir.Tasktracker.Application',
                        'Elixir.Tasktracker.Hierarchy',
                        'Elixir.Tasktracker.Hierarchy.Employee',
                        'Elixir.Tasktracker.Jobs',
                        'Elixir.Tasktracker.Jobs.Task',
                        'Elixir.Tasktracker.Jobs.Time',
                        'Elixir.Tasktracker.Repo','Elixir.TasktrackerWeb',
                        'Elixir.TasktrackerWeb.ChangesetView',
                        'Elixir.TasktrackerWeb.EmployeeController',
                        'Elixir.TasktrackerWeb.EmployeeView',
                        'Elixir.TasktrackerWeb.Endpoint',
                        'Elixir.TasktrackerWeb.ErrorHelpers',
                        'Elixir.TasktrackerWeb.ErrorView',
                        'Elixir.TasktrackerWeb.FallbackController',
                        'Elixir.TasktrackerWeb.Gettext',
                        'Elixir.TasktrackerWeb.LayoutView',
                        'Elixir.TasktrackerWeb.PageController',
                        'Elixir.TasktrackerWeb.PageView',
                        'Elixir.TasktrackerWeb.Router',
                        'Elixir.TasktrackerWeb.Router.Helpers',
                        'Elixir.TasktrackerWeb.SessionController',
                        'Elixir.TasktrackerWeb.TaskController',
                        'Elixir.TasktrackerWeb.TaskView',
                        'Elixir.TasktrackerWeb.TimeController',
                        'Elixir.TasktrackerWeb.TimeView',
                        'Elixir.TasktrackerWeb.UserController',
                        'Elixir.TasktrackerWeb.UserSocket',
                        'Elixir.TasktrackerWeb.UserView']},
              {registered,[]},
              {vsn,"0.0.1"},
              {mod,{'Elixir.Tasktracker.Application',[]}},
              {extra_applications,[logger,runtime_tools]}]}.