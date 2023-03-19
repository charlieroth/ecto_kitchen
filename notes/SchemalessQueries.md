# Schemaless Queries

Most queries in Ecto are written using schemas:

```elixir
MyApp.Repo.all(Post)
```

Ecto also supports schemaless queries:

```elixir
query =
  from p in Post, select: %Post{title, p.title, body: p.body, ...}

MyApp.Repo.all(query)
```

Selecting desired fields without duplication:

```elixir
from "posts", select[:title, :body]
```

Example of an update query changing the title of a post:

```elixir
def update_title(post, new_title) do
  query =
    from "posts",
      where: [id: ^post.id],
      update: [set: [title: ^new_title]]

  MyApp.Repo.update_all(query, [])
end
```

See docs on [`update/3`](https://hexdocs.pm/ecto/Ecto.Query.html#update/3) for supported commands

## `insert_all`, `update_all` and `delete_all`

Ecto allows all database operations to be expressed without a schema

With `insert_all/3` you can insert multiple entries at once into a repository:

```elixir
MyApp.Repo.insert_all(
  Post,
  [
    [title: "hello", body: "world"],
    [title: "another", body: "post"]
  ]
)
```
