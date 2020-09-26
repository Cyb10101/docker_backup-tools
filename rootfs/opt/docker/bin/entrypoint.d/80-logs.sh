#!/usr/bin/env bash

touch /var/log/syslog
chmod 664 /var/log/syslog
chown root:syslog /var/log/syslog

touch /var/log/cron.log
chmod 664 /var/log/cron.log
chown root:syslog /var/log/cron.log
