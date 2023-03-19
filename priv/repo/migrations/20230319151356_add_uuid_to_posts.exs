defmodule EctoKitchen.Repo.Migrations.AddUuidToPosts do
  use Ecto.Migration

  def change do
    drop table(:posts)

    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :author, :string
      add :title, :string
      add :page_views, :integer

      timestamps()
    end
  end
end
