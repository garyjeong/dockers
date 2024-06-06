FROM arm64v8/ubuntu:latest

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    curl \
    wget \
    vim \
    git \
    openssh-server \
    && apt clean

RUN mkdir /var/run/sshd

RUN echo 'root:wjdwhdans' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

RUN sudo apt update && upgrade

WORKDIR /app

CMD ["bash"]