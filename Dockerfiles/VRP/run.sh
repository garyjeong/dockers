#!/bin/bash

# 실행 디렉토리 생성
mkdir -p ./data

# 이전 컨테이너 중지
docker-compose -f docker-compose.yaml down

# OSRM 서비스 실행
docker-compose -f docker-compose.yaml up -d osrm-prepare osrm

# GraphHopper 서비스 실행
docker-compose -f docker-compose.yaml up -d graphhopper-prepare graphhopper

# Valhalla 서비스 실행
docker-compose -f docker-compose.yaml up -d valhalla-prepare valhalla

echo "모든 라우팅 서비스 준비 중..."
echo "- OSRM 서비스는 http://localhost:10000/ 에서 접근 가능합니다."
echo "- GraphHopper 서비스는 http://localhost:8989/ 에서 접근 가능합니다."
echo "- Valhalla 서비스는 http://localhost:8002/ 에서 접근 가능합니다."

# 상태 확인
echo "서비스 상태 확인:"
docker-compose ps

# 엔드포인트 안내
echo ""
echo "라우팅 서비스 접속 정보:"
echo "======================="
echo "OSRM: http://localhost:10000/"
echo "GraphHopper: http://localhost:8989/"
echo "Valhalla: http://localhost:8002/"

echo ""
echo "API 사용 예시:"
echo "============"
echo "OSRM 경로 요청:"
echo "curl \"http://localhost:10000/route/v1/driving/126.9780,37.5665;127.0244,37.5014?steps=true\""
echo ""
echo "GraphHopper 경로 요청:"
echo "curl \"http://localhost:8989/route?point=37.5665,126.9780&point=37.5014,127.0244&vehicle=car\""
echo ""
echo "Valhalla 경로 요청:"
echo "curl http://localhost:8002/route -d '{\"locations\":[{\"lat\":37.5665,\"lon\":126.9780},{\"lat\":37.5014,\"lon\":127.0244}],\"costing\":\"auto\"}'"

# OSRM 서비스 상태 확인
echo ""
echo "OSRM 데이터 처리 진행 상황:"
docker logs osrm-prepare 2>/dev/null || echo "osrm-prepare 컨테이너가 이미 종료되었습니다."

# osrm-prepare 컨테이너가 완료되면 자동으로 삭제
echo ""
echo "osrm-prepare 컨테이너 정리 중..."
docker rm osrm-prepare 2>/dev/null || echo "osrm-prepare 컨테이너가 이미 삭제되었습니다." 