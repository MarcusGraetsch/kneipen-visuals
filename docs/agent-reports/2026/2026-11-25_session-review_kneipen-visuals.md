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

## Nachtrag: Native Windows-Unterstützung

### Lagebild

Das bisherige Repository enthielt ausschließlich Bash-Skripte und den Linux-PulseAudio-Starter. Ein Windows-Nutzer hätte damit nur über WSL arbeiten können. Das offizielle projectM-SDL-Frontend stellt dagegen ein natives 64-Bit-Windows-ZIP mit `projectMSDL.exe` bereit.

### Umsetzung

- `setup-windows.ps1` lädt `projectMSDL-2.0.0-win64.zip` aus dem offiziellen projectM-Frontend-Release.
- Der Download wird vor dem Entpacken gegen SHA-256 `7129cae0757970bd4fb2bf96aa7d6153fe9872d414c88c82b04a6396bdfe235b` geprüft.
- Installation erfolgt unter `%LOCALAPPDATA%\Kneipen-Visuals\`; benutzerspezifische Konfiguration unter `%APPDATA%\projectM\projectMSDL.properties`.
- Die beiden Repository-Presets werden zusätzlich in den Windows-Presetpfad kopiert.
- `start-kneipen-visuals-windows.ps1` und `.cmd` ermöglichen Start aus PowerShell, CMD oder per Doppelklick.

### Validierung

- Offizielles Windows-ZIP temporär heruntergeladen und SHA-256 erfolgreich verifiziert.
- Archivinhalt geprüft: 64-Bit-`projectMSDL.exe`, DLL-Abhängigkeiten, Presets, Texturen und Konfigurationsvorlage vorhanden.
- PowerShell-Code auf PowerShell-5.1-kompatible Konstrukte beschränkt; ein echter Windows-GUI-/Audio-Test ist auf dieser Linux-VM nicht möglich.

### Offenes Risiko

Der verwendete native projectMSDL-Download ist ein offizielles Pre-Release. Der Windows-Test muss daher auf einem echten 64-Bit-Windows-Rechner mit Audioquelle und Beamer erfolgen.

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
