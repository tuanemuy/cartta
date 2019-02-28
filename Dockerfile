FROM rust:1.30.0

WORKDIR /app

RUN rustup override set nightly && \
    cargo update && \
    cargo install diesel_cli --no-default-features --features postgres && \
    cargo install cargo-watch

COPY . /app

ENV ROCKET_DATABASES="{postgres_database={url=\"${DATABASE_URL}\"}}"
ENV ROCKET_PORT=${PORT}

CMD bash -c "diesel setup && ROCKET_ENV=production cargo run --release"