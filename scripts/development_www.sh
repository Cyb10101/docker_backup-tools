#!/usr/bin/env bash
set -e

echo "Cron: Executing $(basename ${0})"

echo "BASH: $(date '+%F %H:%M:%S')" >> /root/development.txt

echo "Cron: Finished $(basename ${0})"
