#!/usr/bin/env bash
set -Eeuo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
[[ $EUID -ne 0 ]] || { echo 'Bitte als normaler Benutzer starten.' >&2; exit 1; }
[[ $(uname -m) == x86_64 ]] || { echo 'Nur x86_64 unterstützt.' >&2; exit 1; }
glibc=$(getconf GNU_LIBC_VERSION | awk '{print $2}')
dpkg --compare-versions "$glibc" ge 2.35 || { echo 'Ubuntu 22.04 oder neuer erforderlich (glibc >= 2.35).' >&2; exit 1; }
sudo apt-get update
sudo apt-get install -y curl ca-certificates libsdl2-2.0-0 pavucontrol
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
deb="$tmp/projectMSDL-2.0.0-Linux.deb"
curl --fail --location --retry 3 'https://github.com/projectM-visualizer/frontend-sdl-cpp/releases/download/2.0.0-pre1/projectMSDL-2.0.0-Linux.deb' -o "$deb"
printf '%s  %s\n' '91f1357b952d3f5964df1aae0b685038383ef5d85a389742c91df7873a54ad2d' "$deb" | sha256sum --check
sudo apt-get install -y "$deb"
command -v projectMSDL >/dev/null || { echo 'projectMSDL fehlt nach Installation.' >&2; exit 1; }
root="$HOME/.local/share/kneipen-visuals"
cfg="${XDG_CONFIG_HOME:-$HOME/.config}/projectM"
mkdir -p "$root/presets" "$root/textures" "$cfg"
for d in /usr/share/projectM /usr/share/projectm; do
  if [[ -d "$d/textures" ]]; then cp -an "$d/textures/." "$root/textures/"; fi
done
cp -f "$repo"/presets/*.milk "$root/presets/"
logo="${1:-$repo/textures/pirata_logo.jpg}"
if [[ -f "$logo" ]]; then cp -f "$logo" "$root/textures/pirata_logo.jpg"; fi
if [[ ! -f "$root/textures/pirata_logo.jpg" ]]; then
  rm -f "$root/presets/Pirata_Laser.milk"
  echo 'WARNUNG: Pirata-Preset deaktiviert. bash setup.sh /pfad/zum/logo.jpg'
fi
config="$cfg/projectMSDL.properties"
if [[ -f "$config" ]]; then cp -f "$config" "$config.bak"; fi
cat > "$config" <<EOF
window.fullscreen = false
window.width = 1280
window.height = 720
projectM.presetPath = $root/presets
projectM.texturePath = $root/textures
projectM.shuffleEnabled = true
projectM.displayDuration = 25
projectM.fps = 60
EOF
for desk in "$HOME/Desktop" "$HOME/Schreibtisch"; do
  [[ -d "$desk" ]] || continue
  cat > "$desk/Kneipen-Visuals.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Kneipen-Visuals starten
Exec=bash "$repo/start-kneipen-visuals.sh"
Icon=multimedia-player
Terminal=false
Categories=AudioVideo;
EOF
  chmod +x "$desk/Kneipen-Visuals.desktop"
done
echo 'Fertig. bash start-kneipen-visuals.sh'
