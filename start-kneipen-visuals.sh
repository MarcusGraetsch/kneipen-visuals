#!/usr/bin/env bash
set -Eeuo pipefail
command -v projectMSDL >/dev/null || { echo 'Bitte zuerst bash setup.sh ausführen.' >&2; exit 1; }
exec projectMSDL "$@"
