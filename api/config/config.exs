# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api,
  ecto_repos: [Api.Repo],
  client_id_salt: "Generate a client id salt with mix phx.gen.secret",
  token_salt: "Generate a token salt with mix phx.gen.secret"

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7DJAofTU/2SE+3wbuDN6B/+zqqrl3bvOURACOGqkUh/QBdAhTsCrZwuywRU6XDak",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Api.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
