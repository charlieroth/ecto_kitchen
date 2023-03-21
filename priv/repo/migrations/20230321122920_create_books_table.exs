defmodule EctoKitchen.Repo.Migrations.CreateBooksTable do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :author, :string
    end
  end
end
