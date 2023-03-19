defmodule EctoKitchen.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :post_id, references(:posts)
      add :text, :string
      timestamps()
    end
  end
end
