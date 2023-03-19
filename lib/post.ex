defmodule EctoKitchen.Post do
  use Ecto.Schema

  schema "posts" do
    field(:author)
    field(:title)
    field(:page_views, default: 0)

    timestamps()
  end

  @spec changeset(%EctoKitchen.Post{}, map()) :: Ecto.Changeset.t()
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:author, :title, :page_views])
    |> validate_required(params, [:author, :title])
  end
end
