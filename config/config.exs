# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :creek_dict_admin,
  ecto_repos: [CreekDictAdmin.Repo]

# Configures the endpoint
config :creek_dict_admin, CreekDictAdminWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IlhoAdocGi/nHo61bGl4/ojMD31MFeRQRSyKscdd77LKhG3boPpi5HUXlZ9M7REG",
  render_errors: [view: CreekDictAdminWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CreekDictAdmin.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
