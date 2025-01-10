# Go compiler
FROM golang as builder
ENV GOOS="linux" GOARCH="amd64"
WORKDIR /go/src/rotate
COPY go/ /go/
RUN go build rotate.go

# Main
FROM ubuntu:24.04

RUN mkdir -p /opt/docker && echo "amd64" > /opt/docker/architecture
ENV DEBIAN_FRONTEND=noninteractive \
    TIMEZONE="Europe/Berlin" \
    LANGUAGE="de_DE"

ADD rootfs/opt/docker/bin/bootstrap.sh /opt/docker/bin/bootstrap.sh
RUN chmod +x /opt/docker/bin/bootstrap.sh && /opt/docker/bin/bootstrap.sh

ADD rootfs/ /
COPY --from=builder /go/src/rotate/rotate /usr/local/bin/

RUN set -x && \
  chmod +x /opt/docker/bin/* && \
  /opt/docker/bin/bootstrap.sh

WORKDIR /root
ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
#CMD ["noop"]
