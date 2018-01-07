defmodule TodobirdWeb.Router do
  use TodobirdWeb, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", TodobirdWeb do
    pipe_through :api

    resources "/users", V1.UserController, except: [:new, :edit]
    resources "/todo-lists", V1.TodoListController, except: [:new, :edit]
  end
end
