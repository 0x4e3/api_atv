# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :atv_api,
  ecto_repos: [AtvApi.Repo]

# Configures the endpoint
config :atv_api, AtvApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A7aNF4GVO/wTtsUM+eTkqw0v2NaV0vlzqRF0m7pF93ruekIV9Dif1g5r9EczrBGt",
  render_errors: [view: AtvApi.ErrorView, accepts: ~w(json)],
  pubsub: [name: AtvApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
