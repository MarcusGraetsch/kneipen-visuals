#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
TARGET_DIR="${HOME}/.projectM"
PRESET_DIR="${TARGET_DIR}/presets"
PROJECTM_VERSION="3.1.8"
PROJECTM_COMMIT="2864bd7c318e1c5a6ae77c5a731982caf696816c"
PROJECTM_SOURCE_URL="https://github.com/projectM-visualizer/projectm.git"
PROJECTM_CACHE_DIR="${HOME}/.cache/kneipen-visuals/projectm-${PROJECTM_VERSION}"
PROJECTM_PREFIX="${HOME}/.local/share/kneipen-visuals/projectm-${PROJECTM_VERSION}"

die() {
    printf 'FEHLER: %s\n' "$*" >&2
    exit 1
}

if [[ "${EUID}" -eq 0 ]]; then
    SUDO=()
else
    command -v sudo >/dev/null 2>&1 || die "sudo wird für die Paketinstallation benötigt."
    SUDO=(sudo)
fi

command -v apt-get >/dev/null 2>&1 || die "Dieses Setup benötigt Ubuntu/Debian mit apt-get."
command -v apt-cache >/dev/null 2>&1 || die "apt-cache wurde nicht gefunden."

projectm_package_available() {
    apt-cache show projectm-pulseaudio 2>/dev/null | grep -q '^Package: projectm-pulseaudio$'
}

install_projectm_from_source() {
    command -v git >/dev/null 2>&1 || die "git wird für den projectM-Quellcode benötigt. Bitte zuerst git installieren."

    printf '%s\n' "Ältere Ubuntu-Version erkannt: projectM ${PROJECTM_VERSION} wird lokal aus dem Quellcode gebaut..."
    "${SUDO[@]}" apt-get install -y build-essential autoconf automake libtool \
        qtbase5-dev qtdeclarative5-dev libqt5opengl5-dev libpulse-dev \
        libgl1-mesa-dev libglew-dev libftgl-dev

    if [[ -d "${PROJECTM_CACHE_DIR}/.git" && "$(git -C "${PROJECTM_CACHE_DIR}" rev-parse HEAD 2>/dev/null || true)" != "${PROJECTM_COMMIT}" ]]; then
        rm -rf -- "${PROJECTM_CACHE_DIR}"
    fi
    if [[ ! -d "${PROJECTM_CACHE_DIR}/.git" ]]; then
        mkdir -p "$(dirname -- "${PROJECTM_CACHE_DIR}")"
        git clone --depth 1 --branch "v${PROJECTM_VERSION}" "${PROJECTM_SOURCE_URL}" "${PROJECTM_CACHE_DIR}"
    fi
    [[ "$(git -C "${PROJECTM_CACHE_DIR}" rev-parse HEAD)" == "${PROJECTM_COMMIT}" ]] || \
        die "Der projectM-Quellcode entspricht nicht dem erwarteten, geprüften Commit ${PROJECTM_COMMIT}."

    if [[ ! -x "${PROJECTM_PREFIX}/bin/projectM-pulseaudio" ]]; then
        rm -rf -- "${PROJECTM_PREFIX}"
        mkdir -p "${PROJECTM_PREFIX}"
        pushd "${PROJECTM_CACHE_DIR}" >/dev/null
        ./autogen.sh
        ./configure --prefix="${PROJECTM_PREFIX}" --enable-pulseaudio --disable-sdl --disable-jack
        make -j"$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 2)"
        make install
        popd >/dev/null
    fi

    [[ -x "${PROJECTM_PREFIX}/bin/projectM-pulseaudio" ]] || \
        die "Der projectM-Quellcode wurde gebaut, aber projectM-pulseaudio fehlt im Installationsverzeichnis."
}

printf '%s\n' '========================================================'
printf '%s\n' '  Kneipen-Visuals: Automatische Einrichtung startet...'
printf '%s\n\n' '========================================================'

printf '%s\n' '[1/5] Installiere Visual-Software und Hilfsprogramme...'
"${SUDO[@]}" apt-get update -qq
"${SUDO[@]}" apt-get install -y pavucontrol unclutter

if projectm_package_available; then
    "${SUDO[@]}" apt-get install -y projectm-pulseaudio
else
    install_projectm_from_source
fi

printf '%s\n' '[2/5] Richte Effekt-Vorlagen ein...'
mkdir -p "${PRESET_DIR}"
if [[ -d /usr/share/projectM/presets ]]; then
    find /usr/share/projectM/presets -maxdepth 1 -type f -exec cp -n -- {} "${PRESET_DIR}/" \;
fi
find "${SCRIPT_DIR}/presets" -maxdepth 1 -type f -name '*.milk' -exec cp -f -- {} "${PRESET_DIR}/" \;

printf '%s\n' '[3/5] Konfiguriere projectM für Vollbild und Musik-Reaktion...'
cat > "${TARGET_DIR}/config.inp" <<EOF
Window Width = 1280
Window Height = 720
Fullscreen = false
Mesh X = 48
Mesh Y = 36
FPS = 60
Texture Size = 1024
Preset Path = ${PRESET_DIR}
Title Font = /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
Menu Font = /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf
Smooth Preset Duration = 5
Preset Duration = 25
Hard Cut Enabled = true
Hard Cut Duration = 20
Hard Cut Sensitivity = 1.5
Beat Sensitivity = 1.2
Aspect Correction = true
Shuffle Enabled = true
Soft Cut Ratings Enabled = false
EOF

printf '%s\n' '[4/5] Deaktiviere automatische Bildschirmsperre, wenn eine GNOME-Sitzung verfügbar ist...'
if command -v gsettings >/dev/null 2>&1 && [[ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ]]; then
    gsettings set org.gnome.desktop.session idle-delay 0 2>/dev/null || true
    gsettings set org.gnome.desktop.screensaver lock-enabled false 2>/dev/null || true
fi

printf '%s\n' '[5/5] Erstelle Start-Symbol auf dem Desktop...'
for desk in "${HOME}/Desktop" "${HOME}/Schreibtisch"; do
    if [[ -d "${desk}" ]]; then
        desktop_file="${desk}/Kneipen-Visuals.desktop"
        cat > "${desktop_file}" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Kneipen-Visuals starten
Comment=Musik-Visuals für den Beamer starten
Exec=${SCRIPT_DIR}/start-kneipen-visuals.sh
Icon=multimedia-player
Terminal=false
Categories=AudioVideo;
EOF
        chmod +x "${desktop_file}"
        if command -v gio >/dev/null 2>&1; then
            gio set "${desktop_file}" metadata::trusted true 2>/dev/null || true
        fi
    fi
done

printf '\n%s\n' '========================================================'
printf '%s\n' '  FERTIG! Alles wurde erfolgreich eingerichtet.'
printf '%s\n' '========================================================'
printf '%s\n' "Startskript: ${SCRIPT_DIR}/start-kneipen-visuals.sh"
