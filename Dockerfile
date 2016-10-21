FROM elixir

# Set the locale, otherwise elixir will complain later on
# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8

ENV MIX_ENV prod

ADD . /gossip
WORKDIR /gossip
RUN mix local.hex --force
RUN mix deps.get --only-prod
RUN mix compile
CMD ["mix", "phoenix.server"]