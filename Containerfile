FROM ghcr.io/ublue-os/base-main:latest

ADD etc etc

RUN systemctl enable podman.socket

RUN bootc container lint
