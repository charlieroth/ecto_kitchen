defmodule EctoKitchen.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field(:email, :string)
  end

  def changeset(account, params) do
    account
    |> cast(params, [:email])
    |> validate_required([:email])
  end
end
