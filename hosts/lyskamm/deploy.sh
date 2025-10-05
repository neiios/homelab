#!/usr/bin/env bash

set -x

rsync -rvt --delete *.volume *.container root@192.168.1.187:/etc/containers/systemd/

ssh root@192.168.1.187 << 'EOF'

set -x

systemctl daemon-reload
systemctl restart \
  caddy.service \
  gluetun.service \
  qbittorrent.service \
  sonarr.service \
  prowlarr.service \
  jellyfin.service

mkdir -pv \
/var/lib/containers/storage/volumes/arr-data/_data/media/{series,movies} \
/var/lib/containers/storage/volumes/arr-data/_data/torrents/{series,movies}
chown -Rc 1000:1000 /var/lib/containers/storage/volumes/arr-data/_data/* 

EOF
