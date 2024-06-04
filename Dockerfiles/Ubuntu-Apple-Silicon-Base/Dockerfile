FROM arm64v8/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    openssh-server \
    sudo \
    htop \
    sysstat \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:wjdwhdans' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22


CMD ["/usr/sbin/sshd", "-D"]
