#!/bin/bash
set -e

# 한국 지도 데이터 다운로드 (없는 경우)
if [ ! -f /graphhopper/south-korea-latest.osm.pbf ]; then
    echo "다운로드 중: 대한민국 지도 데이터"
    wget -q https://download.geofabrik.de/asia/south-korea-latest.osm.pbf -O /graphhopper/south-korea-latest.osm.pbf
fi

# 설정 파일 생성
cat > /graphhopper/config.yml << EOF
datareader.file: /graphhopper/south-korea-latest.osm.pbf
graph.location: /graphhopper/graph-cache

graph.flag_encoders: car
routing.ch.disabling_allowed: true
prepare.min_network_size: 200
prepare.min_one_way_network_size: 200

# 교통 상황 및 속도 제한
profiles:
  - name: car
    vehicle: car
    weighting: fastest
    turn_costs: true

server:
  application_connectors:
    - type: http
      port: 8989
      bind_host: 0.0.0.0
EOF

# GraphHopper 실행
echo "GraphHopper 서버 시작 중..."
java -Xmx1g -Xms1g -jar web/target/graphhopper-web-*.jar server config.yml 