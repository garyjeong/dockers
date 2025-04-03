# VRP 오픈소스 라우팅 엔진 실행 가이드

이 디렉토리에는 VRP(Vehicle Routing Problem) 해결을 위한 라우팅 엔진을 실행하는 Docker Compose 설정이 포함되어 있습니다.

## 지원 라우팅 엔진

- **OSRM**: 빠른 라우팅 계산과 실시간 ETA 제공 (활성화됨)
- **GraphHopper**: 다양한 차량 유형 지원 (활성화됨)
- **Valhalla**: 교통 상황을 고려한 실시간 내비게이션 (활성화됨)

## 설치 및 실행 방법

### 1. 사전 준비

- Docker와 Docker Compose가 설치되어 있어야 합니다.
- 실행 권한 부여: `chmod +x run.sh`

### 2. 실행 방법

```bash
# 간단한 실행 스크립트 사용
./run.sh

# 또는 직접 docker-compose 명령 사용
docker-compose up -d
```

### 3. 각 서비스 URL

- OSRM: http://localhost:10000/
- GraphHopper: http://localhost:8989/
- Valhalla: http://localhost:8002/

## OSRM 트럭 프로필 사용하기

OSRM 트럭 프로필을 사용하려면 docker-compose.yml 파일의 osrm-prepare 서비스 명령어를 수정하세요:

```yaml
command: >
  bash -c "
  apt-get update && apt-get install -y wget && 
  if [ ! -f /data/south-korea-latest.osm.pbf ]; then
    echo '한국 지도 데이터 다운로드 중...' && 
    wget -q https://download.geofabrik.de/asia/south-korea-latest.osm.pbf -O /data/south-korea-latest.osm.pbf;
  fi && 
  echo '트럭 프로필 추출 중...' &&
  osrm-extract -p /opt/truck.lua /data/south-korea-latest.osm.pbf && 
  echo '파티션 생성 중...' &&
  osrm-partition /data/south-korea-latest.osrm && 
  echo '커스터마이징 중...' &&
  osrm-customize /data/south-korea-latest.osrm && 
  echo 'OSRM 데이터 처리 완료!'
  "
```

## API 사용 예시

### OSRM 경로 요청
```
curl "http://localhost:10000/route/v1/driving/126.9780,37.5665;127.0244,37.5014?steps=true"
```

### GraphHopper 경로 요청
```
curl "http://localhost:8989/route?point=37.5665,126.9780&point=37.5014,127.0244&vehicle=car"
```

### Valhalla 경로 요청
```
curl http://localhost:8002/route -d '{"locations":[{"lat":37.5665,"lon":126.9780},{"lat":37.5014,"lon":127.0244}],"costing":"auto"}'
```

## 참고 사항

- GraphHopper와 Valhalla는 초기 데이터 처리에 시간이 소요될 수 있습니다.
- 모든 서비스는 동일한 OSM 데이터(한국 지도)를 사용합니다.
- 각 서비스별 자세한 API 문서:
  - OSRM: http://project-osrm.org/docs/v5.24.0/api/
  - GraphHopper: https://github.com/graphhopper/graphhopper
  - Valhalla: https://github.com/valhalla/valhalla 