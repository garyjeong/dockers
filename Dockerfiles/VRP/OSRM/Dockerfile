FROM ghcr.io/project-osrm/osrm-backend:latest

WORKDIR /data

# 필요한 도구 설치
RUN apt-get update && apt-get install -y \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 한국 지도 데이터 다운로드 및 OSRM 처리를 위한 스크립트
COPY ./prepare_osrm.sh /data/prepare_osrm.sh
RUN chmod +x /data/prepare_osrm.sh

# 포트 노출
EXPOSE 5000

# 시작 스크립트 실행
ENTRYPOINT ["/data/prepare_osrm.sh"] 