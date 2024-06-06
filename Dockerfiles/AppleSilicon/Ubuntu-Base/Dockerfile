FROM arm64v8/ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    vim \
    git \
    && apt-get clean

WORKDIR /app

CMD ["bash"]