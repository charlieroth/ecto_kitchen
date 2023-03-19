import Config

config :ecto_kitchen, ecto_repos: [EctoKitchen.Repo]

config :ecto_kitchen, EctoKitchen.Repo,
  database: "ecto_kitchen",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
