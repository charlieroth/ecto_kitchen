defmodule EctoKitchen.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoKitchen.Comment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "posts" do
    field(:author, :string)
    field(:title, :string)
    field(:page_views, :integer, default: 0)
    field(:category, :string)
    field(:published_at, :naive_datetime)

    has_many(:comment, Comment)

    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:author, :title, :page_views])
    |> validate_required([:author, :title])
  end
end
