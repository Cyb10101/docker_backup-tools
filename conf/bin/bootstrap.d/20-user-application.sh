#!/usr/bin/env bash

addgroup -g "1000" "application" && \
  adduser -D -u "1000" -G "application" -h "/home/application" -s /bin/bash "application" && \
  echo "application":"dev" | chpasswd

chown -R "application":"application" /home/application
