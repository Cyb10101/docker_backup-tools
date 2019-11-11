#!/usr/bin/env bash

apk add tzdata
cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo "${TIMEZONE}" > /etc/timezone
apk del tzdate
