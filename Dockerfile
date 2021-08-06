# Go compiler
FROM golang as golang

ENV GOOS="linux" \
    GOARCH="amd64"

WORKDIR /go/src/rotate
COPY go/ /go/
RUN go build rotate.go

# Main
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive \
    TIMEZONE=Europe/Berlin

RUN apt-get update && \
    apt-get install -y supervisor rsyslog openssh-client sshfs less vim tzdata cron php php-curl rsync rdiff-backup restic && \
    restic self-update && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD rootfs/ /
COPY --from=golang /go/src/rotate/rotate /usr/local/bin/

RUN set -x && \
  chmod +x /opt/docker/bin/* && \
  /opt/docker/bin/bootstrap.sh

WORKDIR /root
ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
#CMD ["noop"]
