FROM rust as build

WORKDIR /usr/src/grafana_generator
COPY . .

RUN cargo build --release
RUN cargo install --path .
CMD ["/usr/local/cargo/bin/grafana-generator"]
