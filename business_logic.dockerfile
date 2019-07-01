FROM elixir:alpine
COPY . /business_logic
WORKDIR /business_logic
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix archive.install hex sobelow --force
RUN mix sobelow
CMD mix run --no-halt