# Multi Tenancy With Query Prefixes

Ecto can run queries in different prefixes using a single pool of database connections

Query prefixes can be useful in different scenarios:
- Multi-tenant applications running on Postgres would define one prefix per client, under a single DB. The prefixes will provide data isolation between the different users of the application, guarenteeing either globally or at the data level that queries and commands act on specific tenats.
- High traffic applications where data is partitioned upfront. Gaming platform may break game data into isolated partitions, each named after a different prefix

Multi-tenacy with query prefixes is expensive to setup and are only usually required in environments where security is a higher priority
