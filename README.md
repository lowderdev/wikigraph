# Wikigraph

TODO:

* Create `filterer`
  * checks datastore (redis?) to determine if uri has been scraped
  * publishes non-scraped uris to
* Create `persister` that writes to neo4j
  * Merge (parent)-[:links_to]->(children) subgraphs to neo4j
* Upon app start spawn supervision tree with `filterer`, `persister`, and `N` number of `scraper` processes
  * `N` not to exceed Wikipedia API rate limit
* Create CLI command to start scraping at specific article

Topic - process diagram

```text
+------------------+
|                  |
|                  v
|        (article-uris-gathered)
|          |                 |
|          v                 v
|      [filterer]       [persister]
|          |                 |
|          v                 v
|  (new-uris-determined)  (neo4j)
|          |
|          v
|      [scraper] x N
|          |
|          |
+----------+
```
