#!/bin/bash
IMAGE_NAME="vroom-image"
DOCKERFILE="Compile.Dockerfile"

docker build -t $IMAGE_NAME -f $DOCKERFILE .

docker run --rm -it -v $(pwd)/output:/workspace/vroom/bin $IMAGE_NAME

cp -r output/* /path/to/local/project/bin/

echo "컴파일된 바이너리 파일이 로컬 프로젝트 디렉토리에 복사되었습니다."