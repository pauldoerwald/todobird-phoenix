# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todobird,
  ecto_repos: [Todobird.Repo]

# Configures the endpoint
config :todobird, TodobirdWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vOIeKwK0T+Erhx+BCv7MU/1Oxn/I/NTEX9+1sEm+i5jqEg0Isjksk7+zCGqXtThW",
  render_errors: [view: TodobirdWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Todobird.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
