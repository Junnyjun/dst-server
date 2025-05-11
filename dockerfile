# Dockerfile
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    STEAMCMD_DIR=/opt/steamcmd \
    DST_DIR=/opt/dst \
    CLUSTER_NAME=MyDSTCluster \
    CLUSTER_TOKEN=YOUR_CLUSTER_TOKEN_HERE \
    CLUSTER_PASSWORD= \
    MAX_PLAYERS=6

# 1. 필수 패키지 설치
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates curl wget lib32gcc1 lib32stdc++6 xz-utils && \
    rm -rf /var/lib/apt/lists/*

# 2. steamcmd 설치
RUN mkdir -p ${STEAMCMD_DIR} && \
    cd ${STEAMCMD_DIR} && \
    wget -qO steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xzf steamcmd.tar.gz && \
    rm steamcmd.tar.gz

# 3. DST 서버 설치
RUN mkdir -p ${DST_DIR} && \
    ${STEAMCMD_DIR}/steamcmd.sh +login anonymous \
      +force_install_dir ${DST_DIR} \
      +app_update 343050 validate \
      +quit

# 4. 클러스터 설정 파일 복사
COPY cluster/ ${DST_DIR}/cluster/

# 5. 시작 스크립트 작성
COPY start_dst.sh /usr/local/bin/start_dst.sh
RUN chmod +x /usr/local/bin/start_dst.sh

WORKDIR ${DST_DIR}

EXPOSE 10999/udp 11000/udp 11001/udp 11002/udp

ENTRYPOINT ["start_dst.sh"]
