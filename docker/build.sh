#!/usr/bin/env zsh
set -e
set -x
export DOCKER_BUILDKIT=1
#年-月-日
timestamp=$(date +'%y-%m-%d')
##git commit hash code
hash=$(git rev-parse --short HEAD)
# shellcheck disable=SC2034
branch=$(git rev-parse --abbrev-ref HEAD)
tag="${timestamp}"-"${hash}"
buildApplication(){

  ## 构建 正式 环境
  docker \
      build \
      -f Dockerfile \
      .. \
      -t aqlog-docker.pkg.coding.net/developerfolio/folio/folio:"${tag}" \
      -t aqlog-docker.pkg.coding.net/developerfolio/folio/folio:latest


  ## 上传镜像仓储
  docker push \
    qlog-docker.pkg.coding.net/developerfolio/folio/folio:"${tag}" & \

  docker push \
    aqlog-docker.pkg.coding.net/developerfolio/folio/folio:latest

}
#parallel run
#buildApplication & buildRabbitmq
buildApplication