# General application configuration
import Config

config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  http: [port: 4000],
  url: [host: "matcherprod-lb-365995941.ap-southeast-1.elb.amazonaws.com", port: 80, scheme: "http"],
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json), layout: false],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "z5teRP6nq4KgyRY1u2nPxoCRFCIvqaRsMLcWkF7VWNeS6mUaV/MjYxUX53XzuXHx"



  config :app, App.Repo,
  username: "postgresadmin",
  password: "postgresadmin123",
  database: "matcherdb",
  hostname: "matcherproddb.cpphg8byl282.ap-southeast-1.rds.amazonaws.com",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  port: "5432",
  url: "ecto://postgresadmin:postgresadmin123@matcherproddb.cpphg8byl282.ap-southeast-1.rds.amazonaws.com/matcherdb"


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
config :logger, level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
#import_config "#{config_env()}.exs"

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
  region: System.get_env("BUCKET_REGION")

config :ex_aws, :s3, %{
  access_key_id: System.get_env("BUCKET_ACCESS_KEY"),
  secret_access_key: System.get_env("BUCKET_SECRET_KEY")
}

config :waffle,
  storage: Waffle.Storage.S3,
  bucket: System.get_env("BUCKET_NAME"),
  asset_host: "http://matcherprod-lb-365995941.ap-southeast-1.elb.amazonaws.com"
