defmodule TodobirdWeb.Router do
  use TodobirdWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodobirdWeb do
    pipe_through :api
  end
end
