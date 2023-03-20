defmodule EctoKitchen.Registration do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
  end

  def changeset(registration, params) do
    registration
    |> cast(params, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
