use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api, ApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :api, Api.Repo,
  username: "graphql_example",
  password: "graphql_example",
  database: "graphql_example_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
