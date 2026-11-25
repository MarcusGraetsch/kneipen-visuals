# Session-Report: Kneipen-Visuals

**Datum:** 2026-11-25
**Scope:** `/root/repos/kneipen-visuals`
**Auftrag:** Repository klonen, den dokumentierten Nutzerablauf prüfen, Fehler beheben, committen/pushen und die lokale Testumgebung anschließend entfernen.

## Lagebild

Der Ausgangsstand enthielt nur `README.md` und ein ZIP-Archiv. Der README-Clone-Befehl war durch Markdown-Syntax in einem Shell-Codeblock unbrauchbar; `setup.sh`, Presets und die Kurz-Anleitung waren nur im Archiv enthalten. Das Setup zielte außerdem pauschal auf `projectm-pulseaudio`, obwohl dieses Paket in den auf der VM aktivierten Ubuntu-Jammy-Quellen nicht verfügbar ist.

## Befunde

- Der direkte Clone-Workflow schlug fehl, weil `setup.sh` im Git-Tree fehlte.
- Der README-Befehl enthielt einen ungültigen Markdown-Link innerhalb eines Shell-Befehls.
- Die ZIP-Datei war eine zweite, nicht automatisch synchronisierte Quelle der Wahrheit.
- Der ursprüngliche Desktop-Eintrag verwendete eine verschachtelte Shell-Zeichenkette mit Hintergrundprozessen. Das ist für Desktop-Launcher fehleranfällig und räumt Hilfsprozesse nicht zuverlässig auf.
- `apt-cache show` liefert auch bei einem unbekannten Paket erfolgreich; ein einfacher Exit-Code-Check hätte die Paketprüfung daher nicht abgesichert.
- Ubuntu 22.04 enthält projectM-Bibliothek und Daten, aber kein installierbares `projectm-pulseaudio`; der bisherige Paket-Guard hat deshalb den Nutzerablauf abgebrochen.

## Umgesetzte Änderungen

- `setup.sh` als versioniertes, idempotentes Ubuntu-Setup ergänzt.
- Paketverfügbarkeit vor `apt-get update/install` geprüft und verständliche Abbruchmeldung ergänzt.
- Preset-Dateien und `LIESMICH_KURZANLEITUNG.txt` aus dem Archiv als normale Repository-Dateien ergänzt.
- `start-kneipen-visuals.sh` mit Prozessbereinigung ergänzt und den Desktop-Starter darauf umgestellt.
- README auf den funktionierenden Clone-Ablauf, Voraussetzungen, Audioauswahl und Fehlerbehebung korrigiert.
- Veraltetes ZIP-Artefakt entfernt, damit keine unkontrollierte Duplikatquelle bestehen bleibt.
- Für ältere Ubuntu-Versionen einen lokalen, auf projectM 3.1.8 gepinnten Quellbuild ergänzt; Installation erfolgt unter `~/.local/share/kneipen-visuals/`.
- Starter erweitert, damit er sowohl das native Paket als auch die lokale Fallback-Installation findet.

## Validierung

- `bash -n setup.sh` und `bash -n start-kneipen-visuals.sh`: erfolgreich.
- Preset-Dateien auf Inhalt und `[preset00]` geprüft: erfolgreich.
- Negativtest mit den VM-Paketquellen: Setup bricht kontrolliert mit Paket-Hinweis ab.
- Isolierter Mock-Test von Installation, Konfiguration, Preset-Kopie, Desktop-Datei und Starter: erfolgreich.
- Frischer lokaler Git-Clone des committen Standes geprüft: Dateien, Ausführbarkeit und Bash-Syntax erfolgreich.
- `git diff --check`: erfolgreich.
- Code-Commit `4410658` nach `origin/main` gepusht.

## Offene Risiken

- Ein echter GUI-/Audio-/Beamer-Test war auf dieser VM nicht sinnvoll möglich: `projectm-pulseaudio` ist in den aktiven Jammy-Quellen nicht vorhanden, und die VM stellt keine Nutzer-Desktop-/Audio-Sitzung für den Anwendungstest bereit.
- Der neue Fallback-Build ist auf Ubuntu 22.04 erfolgreich durchgelaufen. Der echte Beamer-/Audio-Test bleibt wegen fehlender grafischer Sitzung und Hardware offen.

## Nächste Schritte

Auf der Zielmaschine mit Ubuntu 20.04+ testen, anschließend pavucontrol auf eine `.monitor`-Quelle oder das gewünschte USB-Audio-Interface stellen und den Beamer-/Vollbildablauf prüfen.

## Nachtrag: Fallback für ältere Ubuntu-Versionen

### Umsetzung

- Native Paketinstallation bleibt der bevorzugte Weg, wenn `projectm-pulseaudio` verfügbar ist.
- Andernfalls baut `setup.sh` projectM 3.1.8 aus dem offiziellen Repository.
- Der Quellstand ist auf Commit `2864bd7c318e1c5a6ae77c5a731982caf696816c` gepinnt.
- Der Build nutzt Ubuntu-22.04-kompatible Qt5-Paketnamen und installiert ausschließlich unter `~/.local/share/kneipen-visuals/`.

### Validierung

- Vollständiger `setup.sh`-Lauf mit isoliertem HOME auf Ubuntu 22.04.5 LTS: erfolgreich.
- projectM-3.1.8-Quellbuild mit `--enable-pulseaudio --disable-sdl --disable-jack`: erfolgreich.
- Binary-/Linker-Prüfung (`file`, `ldd`): erfolgreich, keine fehlenden Bibliotheken.
- Headless-Lauf mit `QT_QPA_PLATFORM=offscreen`: Prozess startet; erwarteter Timeout mangels GUI-/Audiositzung.
- Starter-Lauf: Hilfsprozesse werden beim Abbruch bereinigt; GUI-Fehler sind in der headless VM erwartbar.
