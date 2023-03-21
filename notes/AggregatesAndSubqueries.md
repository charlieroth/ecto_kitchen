# Aggregates and Subqueries

## Aggregates

Ecto includes an `aggregate/4` function in repositories to calculate aggregates

```elixir
Repo.aggregate(Post, :avg, :page_views)
```

which behind that scenes translates to:

```elixir
Repo.one(from p in Post, select: avg(p.page_views))
```

If you want to calculate the average number of page views for the top 10 posts, you must first query the top 10 posts, then aggregate, not aggregate on the query with top 10 posts since the aggregate is not effected by the use of `limit`.

```elixir
query =
  from Post,
    order_by: [desc: :page_views],
    limit: 10

Repo.aggregate(query, :avg, :page_views)
```

Due to the use of `limit`, behind the scenes, this is translated to:

```elixir
inner_query =
  from MyApp.Post,
    order_by: [desc: :visits],
    limit: 10

query =
  from q in subquery(inner_query),
  select: avg(q.visits)

MyApp.Repo.one(query)
```

## Subqueries

Subqueries in Ecto are created by calling `Ecto.Query.subquery/1` which receives any data structure that can be converted to a query, via the `Ecto.Queryable` protocol, and returns a subquery construct
