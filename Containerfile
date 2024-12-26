FROM ghcr.io/ublue-os/ucore-minimal:latest

ADD etc etc

RUN useradd -m core -G wheel
RUN mkdir /var/home/core/.ssh
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPheveC43Q6d64QT/p3evINcYml7Eho9TDedHcttq7+b" > /var/home/core/.ssh/authorized_keys

RUN systemctl enable podman.socket

RUN bootc container lint
