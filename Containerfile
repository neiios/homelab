FROM ghcr.io/ublue-os/ucore-minimal:latest

ADD etc etc

RUN systemctl enable podman.socket

RUN bootc container lint
