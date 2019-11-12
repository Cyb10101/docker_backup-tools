FROM multiarch/qemu-user-static:x86_64-arm as qemu

# Go compiler
FROM golang:alpine as golang

ENV GOOS="linux" \
    GOARCH="arm" \
    GOARM="7"

WORKDIR /go
COPY go/ /go/
RUN go build rotate.go

# Main
FROM arm32v7/alpine
COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin/

ENV LOG_STDOUT="" \
    LOG_STDERR="" \
    TIMEZONE="Europe/Berlin"

RUN apk add --no-cache bash openssh rsync rdiff-backup php7 php7-curl

COPY .shell-methods.sh .bashrc /root/
COPY .shell-methods.sh .bashrc /home/application/
COPY --from=golang /go/rotate /usr/local/bin/
COPY config/ /opt/docker/
RUN set -x && \
  chmod +x /opt/docker/bin/* && \
  /opt/docker/bin/bootstrap.sh

WORKDIR /root
ENTRYPOINT ["/entrypoint"]
#CMD ["supervisord"]
CMD ["noop"]
