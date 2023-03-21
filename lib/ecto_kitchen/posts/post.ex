defmodule EctoKitchen.Posts.Post do
  use Ecto.Schema

  import Ecto.Changeset

  alias EctoKitchen.Repo
  alias EctoKitchen.Posts.{Comment, Tag}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "posts" do
    field(:author, :string)
    field(:title, :string)
    field(:page_views, :integer, default: 0)
    field(:category, :string)
    field(:published_at, :naive_datetime)

    has_many(:comment, Comment)
    many_to_many(:tags, Tag, join_through: "posts_tags", on_replace: :delete)

    timestamps()
  end

  @doc """
  Calling `put_assoc/4`, tells Ecto those Tags should be associated with this Post. In case a previous
  tag was associated to the Post and not given in `put_assoc/4`, Ecto will invoke the `:on_replace`
  behaviour. The `:delete` behaviour will remove the association between the Post and the removed the Tag
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:author, :title, :page_views, :category, :published_at])
    |> put_assoc(:tags, parse_tags(params))
  end

  @spec parse_tags(map()) :: [%Tag{}]
  def parse_tags(params) do
    (params["tags"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&get_or_insert_tag/1)
  end

  @doc """
  Try to insert a `Tag` with the given name, if same named `Tag` exists, update its name to the
  current value, updating the tag and fetching its `id`
  """
  @spec get_or_insert_tag(String.t()) :: %Tag{}
  def get_or_insert_tag(name) do
    Repo.insert!(
      %Tag{},
      on_conflict: [set: [name: name]],
      conflict_target: [:name]
    )
  end
end
