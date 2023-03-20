defmodule EctoKitchen.Repo.Migrations.CreateProfilesTable do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
    end
  end
end
