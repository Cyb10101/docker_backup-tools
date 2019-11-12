#!/usr/bin/env bash

echo '* * * * * /root/scripts/development_www.sh >&/docker.stdout' >> /etc/crontabs/root
echo '* * * * * cd /root/scripts && /usr/bin/php -d memory_limit=1G ./development_www.php >&/docker.stdout' >> /etc/crontabs/root
