defmodule EctoKitchen.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "profiles" do
    field(:name, :string)
    field(:email, :string)
  end

  def changeset(profile, params) do
    profile
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
  end
end
