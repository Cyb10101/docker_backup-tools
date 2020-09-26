#!/usr/bin/env bash

ln -fns /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
