FROM quay.io/fedora/fedora-bootc:latest

RUN useradd -m core -G wheel
RUN mkdir /var/home/core/.ssh
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPheveC43Q6d64QT/p3evINcYml7Eho9TDedHcttq7+b" > /var/home/core/.ssh/authorized_keys

RUN dnf5 install -y btop

ADD etc etc

RUN systemctl enable podman.socket

RUN bootc container lint
