#!/usr/bin/env bash

CRONTAB_FILE=/root/scripts/crontab.txt

# Add crontab file
if [[ ! -f ${CRONTAB_FILE} ]]; then
  cp /opt/docker/crontab.txt ${CRONTAB_FILE}
  chmod 666 ${CRONTAB_FILE}
fi

# Refresh crontab
crontab ${CRONTAB_FILE}

# Start cron daemon
/usr/sbin/cron
