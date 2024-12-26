#!/usr/bin/env bash
set -eux -o pipefail

install_dev='vda'
install_ignition='https://example.com/config.ign'

sudo dnf install -y kexec-tools coreos-installer 
coreos-installer download -f pxe

kernel=$(ls fedora-coreos-*-live-kernel-x86_64)
initramfs=$(ls fedora-coreos-*-live-initramfs.*.img)
rootfs=$(ls fedora-coreos-*-live-rootfs.*.img)

cat $initramfs $rootfs > combined.img
sudo kexec -l $kernel --initrd=./combined.img  --command-line="coreos.inst.install_dev=${install_dev} coreos.inst.ignition_url=${install_ignition} console=ttyS0"
sudo systemctl kexec