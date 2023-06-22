#!/usr/bin/env bash

if [ -d /root/.ssh ]; then
    chmod -R 600 /root/.ssh
    chmod 644 /root/.ssh/config /root/.ssh/*.pub
    chown -R root:root /root/.ssh
fi
