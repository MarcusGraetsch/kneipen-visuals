#!/usr/bin/env bash
set -Eeuo pipefail

cleanup() {
    [[ -n "${UNCLUTTER_PID:-}" ]] && kill "${UNCLUTTER_PID}" 2>/dev/null || true
    [[ -n "${PAVUCONTROL_PID:-}" ]] && kill "${PAVUCONTROL_PID}" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

command -v projectM-pulseaudio >/dev/null 2>&1 || {
    printf 'FEHLER: projectM-pulseaudio ist nicht installiert. Bitte zuerst setup.sh ausführen.\n' >&2
    exit 1
}

if command -v unclutter >/dev/null 2>&1; then
    unclutter -idle 2 &
    UNCLUTTER_PID=$!
fi

if command -v pavucontrol >/dev/null 2>&1; then
    pavucontrol &
    PAVUCONTROL_PID=$!
fi

exec projectM-pulseaudio
