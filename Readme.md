# Docker backup tools

System with backup tools. The backups are then started via own cron jobs.

## Mounts

```text
./config/.ssh : /root/.ssh
./config/entrypoint : /entrypoint.d
./config/scripts : /root/scripts
./backup : /root/backup
```