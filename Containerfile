FROM quay.io/fedora/fedora-bootc:latest

RUN useradd -m core -G wheel && \
    mkdir /var/home/core/.ssh && \
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPheveC43Q6d64QT/p3evINcYml7Eho9TDedHcttq7+b" > /var/home/core/.ssh/authorized_keys && \
    mkdir -pv /var/lib/systemd/linger/ && touch /var/lib/systemd/linger/core

RUN dnf5 install -y htop age && \
    dnf5 install -y --setopt=install_weak_deps=False neovim && \
    dnf5 clean all && \
    echo "EDITOR=NVIM" >> /etc/profile

ADD etc etc

RUN systemctl enable podman.socket podman-auto-update.timer init-secrets.service && \
    su core -c "systemctl --user enable podman.socket podman-auto-update.timer" && \
    echo "hel" > /etc/hostname

RUN bootc container lint
