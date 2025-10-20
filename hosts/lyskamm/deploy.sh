#!/usr/bin/env bash

# This script manages deployed containers on the server using quadlets.
# It should be idempotent and aims to be as declarative as possible.

rsync -rvt --delete ./quadlets/* root@192.168.1.184:/etc/containers/systemd/

ssh root@192.168.1.184 << 'EOF'

systemctl daemon-reload

systemctl restart \
  caddy.service \
  gluetun.service \
  transmission.service \
  sonarr.service \
  prowlarr.service \
  jellyfin.service

# TODO: figure out how to make arr apps create this folder structure automatically
mkdir --parents --verbose \
  /var/lib/containers/storage/volumes/arr-data/_data/media/{series,movies} \
  /var/lib/containers/storage/volumes/arr-data/_data/torrents/{series,movies}
chown --recursive --changes 1000:1000 /var/lib/containers/storage/volumes/arr-data/_data/* 

EOF
