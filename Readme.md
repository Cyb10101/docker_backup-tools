# Docker backup tools

System with backup tools. The backups are then started via own cron jobs.

## Mounts

```text
./backup : /root/backup
./config/entrypoints : /entrypoint.d
./config/scripts : /root/scripts
./config/ssh : /root/.ssh
```
