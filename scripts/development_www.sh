#!/usr/bin/env bash
set -e
source /opt/docker/bin/functions.sh

cronLog 'Starting...'

echo "BASH: $(date '+%F %H:%M')" >> /root/development.txt

cronLog 'Finished.'
