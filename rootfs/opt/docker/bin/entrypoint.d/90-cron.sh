#!/usr/bin/env bash

CRONTAB_FILE=/root/scripts/crontab.txt

# Add crontab file
if [[ ! -f ${CRONTAB_FILE} ]]; then
  cp /opt/docker/crontab.txt ${CRONTAB_FILE}
fi

# Fix permissions
find /root/scripts -type f ! -iname '*.txt' -exec chmod 777 {} \;
chmod 666 ${CRONTAB_FILE}

# Refresh crontab
crontab ${CRONTAB_FILE}

# Start cron daemon
#/usr/sbin/cron
