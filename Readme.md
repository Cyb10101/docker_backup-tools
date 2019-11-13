# Docker backup tools

System with backup tools. The backups are then started via own cron jobs.

## Mounts

```text
./backup : /root/backup
./config/entrypoints : /entrypoint.d
./config/scripts : /root/scripts
./config/ssh : /root/.ssh
```

## Entry points

The entry points are executed the first time the container is started.
Technically, they can contain anything.

### Entry points: Cron jobs

Via a script entry point, cron jobs can be added.

See file [development.sh](entrypoints/development.php).

File `website.sh`:

```bash
#!/usr/bin/env bash
echo '* * * * * /root/scripts/website_www.sh >&/docker.stdout' >> /etc/crontabs/root
echo '* * * * * cd /root/scripts && /usr/bin/php -d memory_limit=1G ./website_www.php >&/docker.stdout' >> /etc/crontabs/root
```

## Backup: Default script

I recommend to use this as default script.
It's the entry point for a backup through the cron job.

See files:

* [development_www.sh](scripts/development_www.sh).
* [development_www.php](scripts/development_www.php).

File `website_www.sh`:

```bash
#!/usr/bin/env bash
set -e
source /opt/docker/bin/functions.sh

SSH_CONNECTION='my-server'
PRODUCTION_ROOT='/web/website_www'
BACKUP_ROOT='/root/backup/website_www'

cronLog 'Starting...'

# Your backup script

cronLog 'Finished.'
```

### Backup: Database

A complete backup (`website_www.sql`) is always created and copies are made (`website_www.sql.1`, ..., `website_www.sql.n`).

The last backup is deleted every time you run it.
With `rotateFileOrFolder "file" 'maxBackups'` you can specify the maximum backups.

Backup script example for file `website_www.sh`:

```bash
databaseName='website_www'
rotateFileOrFolder "/root/backup/databases/${databaseName}.sql" '15'
backupDatabase 'host' 'username' 'password' "${databaseName}"
```

### Backup: Filesystem with rdiff-backup

The more ideal variant, because a backup always has a timestamp.
However, the server must also have the software `rdiff-backup` installed.

```bash
sudo apt-get install rdiff-backup
```

Backup script example for file `website_www.sh`:

```bash
# Backup filesystem with rdiff-backup
rdiffExcludes=(
  --exclude ${PRODUCTION_ROOT}/.git
  --exclude ${PRODUCTION_ROOT}/public/tmp
)
backupFilesystemRdiffBackup "${SSH_CONNECTION}::${PRODUCTION_ROOT}" "${BACKUP_ROOT}"
```

### Backup: Filesystem with hard links

The fallback strategy if rdiff-backup is not available.

A complete backup (`website_www`) is always created and hard link copies are made (`website_www.1`, ..., `website_www.n`).

The last backup is deleted every time you run it.
With `rotateFileOrFolder "folder" 'maxBackups'` you can specify the maximum backups.

Backup script example for file `website_www.sh`:

```bash
# Backup filesystem with hard links
rsyncExcludes=(
  --exclude=/.git
  --exclude=/public/tmp
)
rotateFileOrFolder "${BACKUP_ROOT}" '3'
backupFilesystemHardLinks "${SSH_CONNECTION}:${PRODUCTION_ROOT}" "${BACKUP_ROOT}"
```
