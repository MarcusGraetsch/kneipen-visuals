# Agent Changelog

## 2026-11-25 — Ältere Ubuntu-Versionen über lokalen projectM-Build unterstützt

- **Befund:** Ubuntu 22.04 stellt `projectm-pulseaudio` nicht bereit, obwohl die projectM-Bibliothek verfügbar ist.
- **Änderung:** `setup.sh` nutzt weiterhin das native Paket, fällt sonst auf den reproduzierbar gepinnten projectM-3.1.8-Quellbuild zurück und installiert ihn ohne Systempfade unter `~/.local/share/kneipen-visuals/`.
- **Starter:** Findet sowohl das native Paket als auch die lokale Fallback-Installation.
- **Dokumentation:** Ubuntu 20.04+ und die zusätzlichen Build-Anforderungen sind beschrieben.

## 2026-11-25 — Clone-Workflow und Ubuntu-Setup repariert

- **Auftrag/Scope:** `/root/work/kneipen-visuals`; Nutzerablauf auf der VM reproduzieren, Fehler beheben, pushen und lokale Testumgebung bereinigen.
- **Befunde:** `setup.sh`, Presets und Kurz-Anleitung fehlten im Git-Tree; README-Clone-Befehl war syntaktisch falsch; ZIP war eine stale Duplikatquelle; `projectm-pulseaudio` ist in den aktiven Jammy-Quellen nicht verfügbar.
- **Änderungen:** Setup, Starter, Presets und Kurz-Anleitung versioniert; Paketguard und Prozessbereinigung ergänzt; README korrigiert; ZIP entfernt.
- **Validierung:** Bash-Syntax, Preset-Checks, Negativtest, Mock-Setup, Mock-Starter, frischer Git-Clone und `git diff --check` erfolgreich.
- **Report:** `docs/agent-reports/2026/2026-11-25_session-review_kneipen-visuals.md`
- **Commit/Push:** `4410658` (`fix: make Ubuntu visual setup runnable from clone`) nach `origin/main` gepusht; Dokumentationscommit folgt.
- **Offene Punkte:** Echter GUI-/Audio-/Beamer-Test auf der Zielmaschine steht aus.
- **Nächster Schritt:** Auf der Zielmaschine mit Ubuntu 20.04+ testen; der Fallback-Build wurde auf Ubuntu 22.04 validiert.
