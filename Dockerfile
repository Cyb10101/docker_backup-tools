# Main
FROM alpine

ENV LOG_STDOUT="" \
    LOG_STDERR="" \
    TIMEZONE="Europe/Berlin"

RUN apk add --no-cache bash openssh rsync rdiff-backup php7 php7-curl

COPY .shell-methods.sh .bashrc /root/
COPY .shell-methods.sh .bashrc /home/application/
COPY conf/ /opt/docker/
RUN set -x && \
  chmod +x /opt/docker/bin/* && \
  /opt/docker/bin/bootstrap.sh

WORKDIR /root
ENTRYPOINT ["/entrypoint"]
#CMD ["supervisord"]
CMD ["noop"]
