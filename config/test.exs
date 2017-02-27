use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :atv_api, AtvApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :atv_api, AtvApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "elixir",
  password: "elixir",
  database: "atv_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
