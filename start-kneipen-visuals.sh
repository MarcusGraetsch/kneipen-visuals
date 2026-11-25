#!/usr/bin/env bash
set -Eeuo pipefail
command -v projectMSDL >/dev/null || { echo 'Bitte zuerst bash setup.sh ausführen.' >&2; exit 1; }
root="$HOME/.local/share/kneipen-visuals"
exec projectMSDL --presetPath "$root/presets" --texturePath "$root/textures" "$@"
