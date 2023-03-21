defmodule EctoKitchen.Repo.Migrations.CreateVisitorsTable do
  use Ecto.Migration

  def change do
    create table(:visitors, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
    end
  end
end
