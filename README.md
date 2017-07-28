# GossipPhx

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Docker how-to

```
docker pull redis
docker pull postgres
docker pull swaggerapi/swagger-ui

docker ps -a -q -f status=exited | foreach { docker rm $_ }

docker run --name gossip_postgres -e POSTGRES_PASSWORD=postgres -d -t -p 5432:5432 postgres
docker run --name gossip_redis -d -t -p 6379:6379 redis
docker run --name gossip_swagger -d -t -p 80:8080 swaggerapi/swagger-ui
docker run --name gossip_elastic -d -t -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" docker.elastic.co/elasticsearch/elasticsearch:5.5.0
```
