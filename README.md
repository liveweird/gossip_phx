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
docker build -t gossip-base -f Dockerfile.base .
docker create -v /gossip/rel --name gossip_vol ubuntu /bin/true
docker build -t gossip-release -f Dockerfile.release . 
docker run --volumes-from gossip_vol -e "MIX_ENV=prod" gossip-release mix release
docker build -t gossip-run -f Dockerfile.run .
docker run --volumes-from gossip_vol -d -t -p 4000:4000 gossip-run gossip/rel/gossip_phx/bin/gossip_phx console
```
