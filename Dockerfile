# Go compiler
FROM golang as golang

ENV GOOS="linux" \
    GOARCH="amd64"

WORKDIR /go
COPY go/ /go/
RUN go build rotate.go

# Main
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive \
    TIMEZONE=Europe/Berlin

RUN apt-get update && \
    apt-get install -y openssh-client less vim tzdata cron php php-curl rdiff-backup && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY .shell-methods.sh .bashrc /root/
COPY --from=golang /go/rotate /usr/local/bin/
COPY config/ /opt/docker/
RUN set -x && \
  chmod +x /opt/docker/bin/* && \
  /opt/docker/bin/bootstrap.sh

WORKDIR /root
ENTRYPOINT ["/entrypoint"]
#CMD ["supervisord"]
CMD ["noop"]
