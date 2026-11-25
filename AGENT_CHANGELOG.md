# Agent Changelog

## 2026-11-25 — Clone-Workflow und Ubuntu-Setup repariert

- **Auftrag/Scope:** `/root/work/kneipen-visuals`; Nutzerablauf auf der VM reproduzieren, Fehler beheben, pushen und lokale Testumgebung bereinigen.
- **Befunde:** `setup.sh`, Presets und Kurz-Anleitung fehlten im Git-Tree; README-Clone-Befehl war syntaktisch falsch; ZIP war eine stale Duplikatquelle; `projectm-pulseaudio` ist in den aktiven Jammy-Quellen nicht verfügbar.
- **Änderungen:** Setup, Starter, Presets und Kurz-Anleitung versioniert; Paketguard und Prozessbereinigung ergänzt; README korrigiert; ZIP entfernt.
- **Validierung:** Bash-Syntax, Preset-Checks, Negativtest, Mock-Setup, Mock-Starter, frischer Git-Clone und `git diff --check` erfolgreich.
- **Report:** `docs/agent-reports/2026/2026-11-25_session-review_kneipen-visuals.md`
- **Commit/Push:** `4410658` (`fix: make Ubuntu visual setup runnable from clone`) nach `origin/main` gepusht; Dokumentationscommit folgt.
- **Offene Punkte:** Echter GUI-/Audio-/Beamer-Test auf der Zielmaschine steht aus.
- **Nächster Schritt:** Auf der Zielmaschine mit Ubuntu 26.10+ testen.
