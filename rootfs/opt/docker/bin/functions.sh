#!/usr/bin/env bash
set -e

cronLog() {
  echo "$(date '+%F %H:%M') Cron '$(basename ${0})': ${1}"
}

createFolder() {
  if [ ! -d ${1} ]; then
    mkdir -p ${1}
  fi
  if [ ! -d ${1} ]; then
    echo "ERROR: Can not create folder '${1}'!"
    exit 1
  fi
}

backupDatabase() {
  dbHost="${1}"
  dbUsername="${2}"
  dbPassword="${3}"
  dbDatabase="${4}"
  filename="${5}"
  if [ -z "${filename}" ]; then
    filename="${dbDatabase}"
  fi

  cronLog 'Backup database...'
  createFolder '/root/backup/databases'

  ssh ${SSH_CONNECTION} "mysqldump --opt --skip-comments --host='${dbHost}' --user='${dbUsername}' --password='${dbPassword}' '${dbDatabase}'" \
    | (echo "CREATE DATABASE IF NOT EXISTS \`${dbDatabase}\`;USE \`${dbDatabase}\`;" && cat) \
    > /root/backup/databases/${filename}.sql
}

backupFilesystemRdiffBackup() {
  source="${1}"
  destination="${2}"
  cronLog 'Backup filesystem with rdiff-backup...'
  rdiff-backup -bv0 ${rdiffExcludes[@]} ${source}/ ${destination}/
}

backupFilesystemHardLinks() {
  source="${1}"
  destination="${2}"
  cronLog 'Backup filesystem with hard links...'

  linkDestination=""
  if [ -d "${destination}.1" ]; then
    linkDestination="--link-dest=${destination}.1/"

    # Prepare old folder
    cp -al "${destination}.1/" "${destination}/"
  fi

  # Sync folder
  rsync -a --delete ${rsyncExcludes[@]} ${linkDestination} "${source}/" "${destination}/"
}

rotateFileOrFolder() {
  if [ -d ${1} ] || [ -f ${1} ]; then
    binRotate='/usr/local/bin/rotate'
    if [[ ${2} =~ ^-?[0-9]+$ ]] && [[ ${2} > 0 ]]; then
      ${binRotate} -max ${2} "${1}"
    else
      ${binRotate} "${1}"
    fi
  fi
}
