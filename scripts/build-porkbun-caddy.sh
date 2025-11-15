#!/usr/bin/env bash

DRY_RUN="${DRY_RUN:-true}"
COMMIT_HASH="$(git rev-parse HEAD)"

while [[ $# -gt 0 ]]; do
	case "$1" in
	--push) DRY_RUN=false ;;
	*)
		echo "Unknown argument: $1" >&2
		exit 1
		;;
	esac
	shift
done

function build() {
	podman build \
		--tag ghcr.io/neiios/caddy:$COMMIT_HASH \
		--tag ghcr.io/neiios/caddy:latest \
		./containers/caddy
}

function push() {
	[[ "${DRY_RUN}" == "true" ]] && return 0

	if [[ -z ${GITHUB_TOKEN:-} ]]; then
		echo "GITHUB_TOKEN not set, cannot push images." >&2
		return 1
	fi

	printf '%s' "${GITHUB_TOKEN}" | sudo podman login ghcr.io --username neiios --password-stdin
	podman push ghcr.io/neiios/caddy:$COMMIT_HASH
	podman push ghcr.io/neiios/caddy:latest
}

build && push
