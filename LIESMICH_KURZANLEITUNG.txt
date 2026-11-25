# Pirata Patata – Kneipen-Visuals

Native Musikvisuals mit projectMSDL 2.0.0-pre1 und MilkDrop-2-Presets. Das offizielle Paket enthält eine projectM-4-Entwicklungsversion, nicht exakt libprojectM 4.1.8. Der Hersteller kennzeichnet es als Pre-Release; vor der Party testen.

## Ubuntu (22.04 oder neuer, x86_64)
```bash
git pull
bash setup.sh /pfad/zum/pirata_logo.jpg
bash start-kneipen-visuals.sh
```
Bei Erstinstallation zuerst das Repository klonen. Das Setup installiert das offizielle DEB mit SHA-256-Prüfung über apt. Keine automatische Installation von projectM 3.x mehr. Alte Installationen bleiben bestehen, werden aber nicht gestartet.

## Windows (64 Bit)
```powershell
git pull
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup-windows.ps1 -LogoPath C:\Pfad\pirata_logo.jpg
.\start-kneipen-visuals-windows.cmd
```
Das Setup lädt das offizielle ZIP mit SHA-256-Prüfung. Keine WSL-Installation. Alternativ das Logo unter textures/pirata_logo.jpg ablegen. Ohne Logo wird Pirata_Laser bei der Installation ausgelassen. Beide Setups sichern vorhandene SDL-Konfigurationen als .bak.

## Bedienung
ESC Menü, Ctrl+F Vollbild, Ctrl+M Monitorwechsel, Space Preset sperren, N nächstes, R zufälliges Preset, Ctrl+I Audioquelle wechseln. Unter Linux bei Audio-Problemen `SDL_AUDIODRIVER=pulseaudio bash start-kneipen-visuals.sh` versuchen; pavucontrol kann Monitor- oder Mikrofonquelle zuweisen. Windows: Audioquelle in Settings auswählen.

## Status
Native GPU-Shader und Textur müssen auf beiden Systemen noch live getestet werden. HTML-Deck bleibt nur als optionaler Altbestand. [Upstream-Release](https://github.com/projectM-visualizer/frontend-sdl-cpp/releases/tag/2.0.0-pre1).
