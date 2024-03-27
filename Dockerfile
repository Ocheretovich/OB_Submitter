FROM rust:buster as builder

RUN apt-get update && apt-get install -y g++ make python3 git libclang-dev clang

WORKDIR /build
COPY . .
RUN cargo build --release

FROM debian:buster-slim

WORKDIR /app

RUN apt-get update && apt install -y libpq-dev openssl ca-certificates
COPY --from=builder /build/target/release/submitter .