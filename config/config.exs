# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :invoice_manager,
  ecto_repos: [InvoiceManager.Repo]

# Configures the endpoint
config :invoice_manager, InvoiceManager.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RxT3tuurTtMFC+bx6Ge+dNeCaMAcqgoC+sQ6RAQzVW10oEfCjhUDTWykhQJSzGCt",
  render_errors: [view: InvoiceManager.ErrorView, accepts: ~w(html json)],
  pubsub: [name: InvoiceManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
