# Dynamic Queries

Ecto was designed to have an expressive query API that leverages Elixir syntax to write pre-compiled queries for performance and safety

Queries with keyword syntax:

```elixir
import Ecto.Query

from p in Post,
    where: p.author == "Charlie Roth" and p.category == "Elixir",
    where: p.published_at > ^minimum_date,
    order_by: [desc: p.published_at]
```

Queries with pipe-based syntax:

```elixir
import Ecto.Query

Post
|> where([p], p.author == "Charlie Roth" and p.category == "Elixir")
|> where([p], p.published_at > ^minimum_date)
|> order_by([p], desc: p.published_at)
```

Query with pipe-based and keyword syntax:

```elixir
import Ecto.Query

Post
|> where(author: "Charlie Roth", category: "Elixir")
|> where([p], p.published_at > ^minimum_date)
|> order_by(desc: p.published_at)
```
