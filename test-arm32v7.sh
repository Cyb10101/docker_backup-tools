#!/usr/bin/env bash

dockerImage='test/backup-tools:arm32v7'
dockerContainer='test_backup_tools_arm32v7'

removeContainer() {
  if [ "$(docker ps -a | grep ${dockerContainer})" ]; then
    docker stop ${dockerContainer}
  fi
  if [ "$(docker ps -a | grep ${dockerContainer})" ]; then
    docker rm ${dockerContainer}
  fi
}

docker run --rm --privileged multiarch/qemu-user-static:register --reset

removeContainer
docker build --rm -t ${dockerImage} -f Dockerfile . && \
docker run --rm -d --name ${dockerContainer} \
  -v /home/${USER}/projects/docker_backup-tools/backup:/root/backup \
  -v /home/${USER}/projects/docker_backup-tools/docker/entrypoints:/entrypoint.d \
  -v /home/${USER}/projects/docker_backup-tools/docker/scripts:/root/scripts \
  -v /home/${USER}/projects/docker_backup-tools/config/ssh:/root/.ssh \
  ${dockerImage} && \

docker exec -ti ${dockerContainer} bash
removeContainer
