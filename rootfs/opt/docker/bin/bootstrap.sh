#!/usr/bin/env bash
set -e

createEntrypoint() {
    ln -sf /opt/docker/bin/entrypoint.sh /entrypoint

    # Create /entrypoint.d
    mkdir -p /entrypoint.d
    chmod 700 /entrypoint.d
    chown root:root /entrypoint.d

    echo '#!/usr/bin/env bash' > /entrypoint.d/placeholder.sh
    echo "echo 'Custom entrypoint'" >> /entrypoint.d/placeholder.sh
    chmod 700 /entrypoint.d/placeholder.sh
}

# Clean apt
apt-get clean

# Update packages
apt-get update
apt-get -y dist-upgrade

# Set timezone and locale
apt-get -y install locales language-pack-de
echo "${TIMEZONE}" > /etc/timezone
update-locale LANG="${LANGUAGE}.UTF-8"

# Create entrypoint
createEntrypoint

# Install apps
apt-get install -y supervisor rsyslog openssh-client sshfs \
    less vim tzdata cron curl ncdu php php-curl rsync rdiff-backup restic && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clean apt
apt-get clean
rm -rf /var/lib/apt/lists/*
