FROM elixir:alpine
COPY . /app
WORKDIR /app
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix archive.install hex sobelow --force
RUN mix sobelow
CMD mix run --no-halt