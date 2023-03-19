defmodule EctoKitchen.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field(:author, :string)
    field(:title, :string)
    field(:page_views, :integer, default: 0)

    timestamps()
  end

  @spec changeset(%EctoKitchen.Post{}, map()) :: Ecto.Changeset.t()
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:author, :title, :page_views])
    |> validate_required([:author, :title])
  end
end
