#!/bin/bash
set -e

mkdir -p /valhalla/data
cd /valhalla/data

# 한국 지도 데이터 다운로드 (없는 경우)
if [ ! -f /valhalla/data/south-korea-latest.osm.pbf ]; then
    echo "다운로드 중: 대한민국 지도 데이터"
    wget -q https://download.geofabrik.de/asia/south-korea-latest.osm.pbf -O /valhalla/data/south-korea-latest.osm.pbf
fi

# Valhalla 설정 파일 생성
valhalla_build_config --mjolnir-tile-dir /valhalla/data/tiles --mjolnir-tile-extract /valhalla/data/tiles.tar --mjolnir-timezone /valhalla/data/timezones.sqlite --mjolnir-admin /valhalla/data/admins.sqlite > /valhalla/data/valhalla.json

# 타일 생성
echo "타일 생성 중..."
valhalla_build_tiles -c /valhalla/data/valhalla.json /valhalla/data/south-korea-latest.osm.pbf

# 타일 추가 처리
echo "타일 추가 처리 중..."
valhalla_build_extract -c /valhalla/data/valhalla.json -v
valhalla_build_stats -c /valhalla/data/valhalla.json

# Valhalla 서버 실행
echo "Valhalla 서버 시작 중..."
exec valhalla_service /valhalla/data/valhalla.json 1 