#!/usr/bin/env bash

chmod -R 600 /root/.ssh
chmod 644 /root/.ssh/config /root/.ssh/*.pub
chown -R root:root /root/.ssh
