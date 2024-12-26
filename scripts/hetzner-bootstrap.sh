#!/usr/bin/env bash
set -eux -o pipefail

# This script bootstraps a server from a custom bootc image
# It is intended to be run in the Hetzner rescue environment (based on Debian 12)
# Tested with the smallest Intel VPS with 4GB of RAM
# Hacky? Absolutely.

apt -y install podman --no-install-suggests

update-alternatives --set iptables /usr/sbin/iptables-legacy

mount -o size=4G -t tmpfs none /var/lib/containers

podman run --rm --privileged --pid=host \
   -v /var/lib/containers:/var/lib/containers -v /dev:/dev --security-opt label=type:unconfined_t \
   ghcr.io/neiios/homelab-bootc:latest bootc install to-disk /dev/sda --filesystem=btrfs --wipe