#!/usr/bin/env bash

if [ -d /root/.ssh ]; then
  chown -R root:root /root/.ssh
  if [ -f /root/.ssh/config ]; then
    chmod 600 /root/.ssh/config
  fi
fi

if [ -d /home/application/.ssh ]; then
  chown -R application:application /home/application/.ssh
  if [ -f /home/application/.ssh/config ]; then
    chmod 600 /home/application/.ssh/config
  fi
fi
