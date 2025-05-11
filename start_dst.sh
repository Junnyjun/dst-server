#!/bin/bash
set -e

# 환경 변수로 덮어쓰기 가능
CLUSTER=${CLUSTER_NAME}
TOKEN=${CLUSTER_TOKEN}
PASS=${CLUSTER_PASSWORD}
MAXP=${MAX_PLAYERS}

# cluster_token.txt 설정
echo "${TOKEN}" > cluster/cluster_token.txt

# steam 인증 파일 디렉터리 권한
mkdir -p ~/.steam/sdk32

# 서버 실행 (surface shard)
bin/dontstarve_dedicated_server_nullrenderer \
  -console \
  -cluster ${CLUSTER} \
  -shard Master

# 동굴 shard 추가 실행을 원하면 추가로 & 백그라운드 실행
# bin/dontstarve_dedicated_server_nullrenderer -console -cluster ${CLUSTER} -shard Caves &
