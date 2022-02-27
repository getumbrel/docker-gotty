ARG VERSION=v1.0.1

FROM debian:bullseye-slim AS builder

ARG VERSION

WORKDIR /build

ADD https://github.com/yudai/gotty/releases/download/${VERSION}/gotty_linux_arm.tar.gz gotty-aarch64.tar.gz
ADD https://github.com/yudai/gotty/releases/download/${VERSION}/gotty_linux_amd64.tar.gz gotty-x86_64.tar.gz

RUN tar -xzvf "gotty-$(uname -m).tar.gz"

FROM debian:bullseye-slim

RUN adduser --disabled-password --uid 1000 --home /data --gecos "" gotty
USER gotty
WORKDIR /data

COPY --from=builder /build/gotty /bin/gotty

EXPOSE 8080

ENTRYPOINT ["gotty"]
