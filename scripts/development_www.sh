#!/usr/bin/env bash
set -e
source /opt/docker/bin/functions.sh

cronLog 'Starting...'

echo "BASH: $(date '+%F %H:%M')" >> /root/backup/development.txt
echo "BASH Output: $(date '+%F %H:%M')";
# rsync /tmp/error /tmp/error

cronLog 'Finished.'
