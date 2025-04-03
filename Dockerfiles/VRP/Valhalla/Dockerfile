FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# 필요한 도구 및 종속성 설치
RUN apt-get update && apt-get install -y \
    git cmake make libtool pkg-config g++ gcc jq \
    libcurl4-openssl-dev libprotobuf-dev libgeos-dev \
    libgeos++-dev liblua5.2-dev libspatialite-dev libsqlite3-dev \
    curl wget unzip luajit protobuf-compiler \
    libboost-all-dev libsqlite3-mod-spatialite zlib1g-dev locales \
    python3-dev python3-pip python3-venv \
    liblz4-dev \
    libluajit-5.1-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /valhalla

# Valhalla 다운로드 및 빌드
RUN git clone --depth=1 https://github.com/valhalla/valhalla.git . \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_SERVICES=OFF \
    && make -j$(nproc) \
    && make install \
    && ldconfig

# 한국 지도 데이터 다운로드 및 Valhalla 처리를 위한 스크립트
COPY ./prepare_valhalla.sh /valhalla/prepare_valhalla.sh
RUN chmod +x /valhalla/prepare_valhalla.sh

# 포트 노출
EXPOSE 8002

# 시작 스크립트 실행
ENTRYPOINT ["/valhalla/prepare_valhalla.sh"] 