# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :umedia_web,
  namespace: UmediaWeb,
  ecto_repos: [Umedia.Repo]

# Configures the endpoint
config :umedia_web, UmediaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BTqd5GjsS26eDI0Lv0UdexJCOf8w5vfVj0uaKn0Mn7BCafFUyjZcnm7XXif52fTH",
  render_errors: [view: UmediaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UmediaWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :umedia_web, :generators,
  context_app: :umedia

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
