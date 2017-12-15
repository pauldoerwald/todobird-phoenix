defmodule TodobirdWeb.Router do
  use TodobirdWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1/", TodobirdWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit] do
      resources "/todo_lists", TodoListController, except: [:new, :edit]
    end
  end
end
