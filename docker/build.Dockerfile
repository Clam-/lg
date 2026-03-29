FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    file \
    python3 \
    python3-dev \
    python3-setuptools \
    swig \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

