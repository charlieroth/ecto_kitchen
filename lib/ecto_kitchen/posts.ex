defmodule EctoKitchen.Posts do
  import Ecto.Query
  alias EctoKitchen.Repo
  alias EctoKitchen.Posts.Post

  def create_posts_from_keyword_list(posts_keyword_list) do
    Repo.insert_all(Post, posts_keyword_list)
  end

  def create_post(post_params) do
    %Post{}
    |> Post.changeset(post_params)
    |> Repo.insert!()
  end

  def get_post(id) do
    Repo.get!(Post, id)
  end

  def list_posts() do
    query = from(p in Post, select: [:id, :title, :author, :page_views])
    Repo.all(query)
  end

  def update_title(post, new_title) do
    post_id = Ecto.UUID.dump!(post.id)

    query =
      from("posts",
        where: [id: ^post_id],
        update: [set: [title: ^new_title]]
      )

    Repo.update_all(query, [])
  end

  def increment_page_views(post) do
    post_id = Ecto.UUID.dump!(post.id)

    query =
      from("posts",
        where: [id: ^post_id],
        update: [inc: [page_views: 1]]
      )

    Repo.update_all(query, [])
  end

  def reset_post_title(post) do
    post_id = Ecto.UUID.dump!(post.id)
    query = from(p in Post, where: [id: ^post_id])
    Repo.update_all(query, set: [title: ""])
  end

  def delete_post(post) do
    query = from(p in Post, where: [id: ^post.id])
    Repo.delete_all(query, [])
  end

  def recent_category_posts_from_author(author, category, published_at) do
    query =
      Post
      |> where(author: ^author)
      |> where(category: ^category)
      |> where([p], p.published_at > ^published_at)
      |> order_by(desc: :published_at)

    Repo.all(query, [])
  end

  @doc """
  A toy example of search functionality using dynamic query builder pattern

  A user can configure how to traverse all posts in many different ways.
  For example the user may choose how to order the data, filter by author or
  category, as well as select posts published after a certain date.
  """
  def search_posts(params) do
    Post
    |> order_by(^filter_order_by(params["order_by"]))
    |> where(^filter_where(params))
    |> Repo.all()
  end

  defp filter_order_by("published_at_desc") do
    [desc: dynamic([p], p.published_at)]
  end

  defp filter_order_by("published_at_asc") do
    [asc: dynamic([p], p.published_at)]
  end

  defp filter_order_by(_), do: []

  defp filter_where(params) do
    Enum.reduce(params, dynamic(true), fn
      {"author", value}, dynamic ->
        dynamic([p], ^dynamic and p.author == ^value)

      {"category", value}, dynamic ->
        dynamic([p], ^dynamic and p.category == ^value)

      {"published_at", value}, dynamic ->
        dynamic([p], ^dynamic and p.published_at > ^value)

      {_, _}, dynamic ->
        dynamic
    end)
  end

  def average_page_views() do
    Post |> Repo.aggregate(:avg, :page_views)
  end

  def top_average_page_views(limit) do
    query =
      from(Post,
        order_by: [desc: :page_views],
        limit: ^limit
      )

    Repo.aggregate(query, :avg, :page_views)
  end
end
