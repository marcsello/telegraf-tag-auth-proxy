FROM golang:1.26-alpine3.23 as builder

COPY . /src/
WORKDIR /src

RUN apk add --no-cache make=4.4.1-r3 && make -j "$(nproc)"

FROM alpine:3.23

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates

COPY --from=builder /src/main /app/main

USER 1000
ENTRYPOINT [ "/app/main" ]
