FROM arm64v8/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    htop \
    sysstat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir /var/run/sshd

RUN echo 'root:wjdwhdans' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

RUN sudo apt update && upgrade

CMD ["/usr/sbin/sshd", "-D"]
