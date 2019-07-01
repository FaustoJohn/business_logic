FROM elixir:alpine
COPY ./business_logic/ /business_logic
WORKDIR /business_logic
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
CMD mix run --no-halt