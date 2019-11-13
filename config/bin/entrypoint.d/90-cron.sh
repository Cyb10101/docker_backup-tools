#!/usr/bin/env bash

# Clear crontab
echo '' > /etc/crontabs/root

# Start cron daemon
/usr/sbin/crond
