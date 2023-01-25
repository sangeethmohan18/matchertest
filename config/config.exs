# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "9z77OMtr"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :app, App.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :ex_aws,
  debug_requests: true,
  region: "local"

config :ex_aws, :s3, %{
  scheme: System.get_env("BUCKET_SCHEMA", "http://"),
  host: System.get_env("BUCKET_HOST", "localhost"),
  port: System.get_env("BUCKET_PORT", "9000"),
  region: System.get_env("BUCKET_REGION", "local"),
  bucket: System.get_env("BUCKET_NAME"),
  access_key_id: System.get_env("BUCKET_ACCESS_KEY"),
  secret_access_key: System.get_env("BUCKET_SECRET_KEY")
}

config :waffle,
  storage: Waffle.Storage.S3,
  bucket: System.get_env("BUCKET_NAME"),
  asset_host: System.get_env("WAFFLE_BUCKET_ACCESS_KEY")
