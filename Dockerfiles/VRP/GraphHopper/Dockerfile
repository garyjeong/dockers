FROM openjdk:17-slim

WORKDIR /graphhopper

# 필요한 도구 설치
RUN apt-get update && apt-get install -y \
    wget \
    git \
    curl \
    maven \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# GraphHopper 다운로드 및 설정
RUN git clone https://github.com/graphhopper/graphhopper.git . \
    && mvn clean package -DskipTests

# 한국 지도 데이터 다운로드를 위한 스크립트
COPY ./prepare_graphhopper.sh /graphhopper/prepare_graphhopper.sh
RUN chmod +x /graphhopper/prepare_graphhopper.sh

# 포트 노출
EXPOSE 8989

# 시작 스크립트 실행
ENTRYPOINT ["/graphhopper/prepare_graphhopper.sh"] 