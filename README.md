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
docker pull quay.io/coreos/etcd
docker pull wurstmeister/kafka
docker pull alpine
docker pull grafana/grafana
docker pull buoyantio/linkerd
docker pull ubuntu
docker pull nginx
docker pull gliderlabs/consul-server
docker pull elixir
docker pull postgres
docker pull haproxy
docker pull gliderlabs/registrator
docker pull wurstmeister/zookeeper

docker ps -a -q -f status=exited | foreach { docker rm $_ }

docker run --name gossip_postgres -e POSTGRES_PASSWORD=postgres -d -t -p 5432:5432 postgres
docker run --name gossip_redis -d -t -p 6379:6379 redis

docker build -t gossip-base -f Dockerfile.base .
docker create -v /gossip/_build/prod/rel --name gossip_vol ubuntu /bin/true
docker build -t gossip-release -f Dockerfile.release .
docker run --volumes-from gossip_vol -e "MIX_ENV=prod" gossip-release mix release.clean
docker run --volumes-from gossip_vol -e "MIX_ENV=prod" gossip-release mix release --env=prod --verbose
docker run --volumes-from gossip_vol gossip-release mkdir /gossip/_build/prod/rel/p_1
docker run --volumes-from gossip_vol gossip-release mkdir /gossip/_build/prod/rel/p_2
docker cp config/gossip_phx_1.conf gossip_vol:/gossip/_build/prod/rel/p_1/gossip_phx.conf
docker cp config/gossip_phx_2.conf gossip_vol:/gossip/_build/prod/rel/p_2/gossip_phx.conf
docker build -t gossip-run -f Dockerfile.run .
docker run --volumes-from gossip_vol -d -t -p 4000:4000 -e "RELEASE_CONFIG_DIR=/gossip/_build/prod/rel/p_1" gossip-run gossip/_build/prod/rel/gossip_phx/bin/gossip_phx console
docker run --volumes-from gossip_vol -d -t -p 4001:4001 -e "RELEASE_CONFIG_DIR=/gossip/_build/prod/rel/p_2" gossip-run gossip/_build/prod/rel/gossip_phx/bin/gossip_phx console
docker build -t gossip-haproxy -f Dockerfile.haproxy .
docker run -d -p 80:80 --name gossip-haproxy gossip-haproxy

docker run -d --net=host --name=consul gliderlabs/consul-server -bootstrap
docker run -d --net=host --name=registrator --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator consul://localhost:8500
```
