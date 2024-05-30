FROM arm64v8/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git openssh-server \
    sudo htop sysstat libz-dev libssl-dev libcurl4-gnutls-dev \
    libexpat1-dev gettext pkg-config cmake gcc g++\
    libasio-dev libglpk-dev libboost-all-dev\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace

WORKDIR /workspace

RUN git clone https://github.com/VROOM-Project/vroom.git
RUN git checkout -f v1.14.0

WORKDIR /workspace/vroom/src

RUN make

ENTRYPOINT ["/bin/bash"]
