defmodule EctoKitchen.Repo do
  use Ecto.Repo,
    otp_app: :ecto_kitchen,
    adapter: Ecto.Adapters.Postgres
end
