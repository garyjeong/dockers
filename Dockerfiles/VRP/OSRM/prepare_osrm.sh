#!/bin/bash
set -e

# 한국 지도 데이터 다운로드 (없는 경우)
if [ ! -f /data/south-korea-latest.osm.pbf ]; then
    echo "다운로드 중: 대한민국 지도 데이터"
    wget -q https://download.geofabrik.de/asia/south-korea-latest.osm.pbf -O /data/south-korea-latest.osm.pbf
fi

# 자동차 프로필 추출
echo "자동차 프로필 추출 중..."
osrm-extract -p /opt/car.lua /data/south-korea-latest.osm.pbf

# 데이터 전처리
echo "데이터 파티셔닝 중..."
osrm-partition /data/south-korea-latest.osrm

# 교통 상황 데이터 적용 (있는 경우)
if [ -f /data/traffic_data.csv ]; then
    echo "교통 상황 데이터 적용 중..."
    osrm-customize --segment-speed-file /data/traffic_data.csv /data/south-korea-latest.osrm
else
    echo "교통 상황 데이터 적용 중..."
    osrm-customize /data/south-korea-latest.osrm
fi

# OSRM 서버 시작
echo "OSRM 서버 시작 중..."
exec osrm-routed --max-matching-size -1 --algorithm mld /data/south-korea-latest.osrm 