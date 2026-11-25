# Pirata Patata – Kneipen-Visuals

Native Musikvisuals mit projectMSDL 2.0.0-pre1 und MilkDrop-2-Presets. Das offizielle Paket enthält eine projectM-4-Entwicklungsversion, nicht exakt libprojectM 4.1.8. Der Hersteller kennzeichnet es als Pre-Release; vor der Party testen.

## Ubuntu (22.04 oder neuer, x86_64)
```bash
git clone https://github.com/MarcusGraetsch/kneipen-visuals.git
cd kneipen-visuals
bash setup.sh
bash start-kneipen-visuals.sh
```
Bei bestehendem Clone stattdessen `git pull` und `bash setup.sh` ausführen. Das Setup installiert das offizielle DEB mit SHA-256-Prüfung über apt. Keine automatische Installation von projectM 3.x mehr. Alte Installationen bleiben bestehen, werden aber nicht gestartet.

## Windows (64 Bit)
```powershell
git clone https://github.com/MarcusGraetsch/kneipen-visuals.git
cd kneipen-visuals
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup-windows.ps1
.\start-kneipen-visuals-windows.cmd
```
Das Setup lädt das offizielle ZIP mit SHA-256-Prüfung. Keine WSL-Installation. Das mitgelieferte PNG unter `textures/pirata_logo.png` wird automatisch installiert; keine manuelle Dateiauswahl. Bei bestehendem Clone `git pull` und Setup erneut ausführen. Fehlt das PNG, bricht das Setup mit einer klaren Fehlermeldung ab. Beide Setups sichern vorhandene SDL-Konfigurationen als .bak.

## Pirata-Preset
Im Preset-Menü `Pirata_Laser.milk` auswählen und bei Bedarf sperren. Das Logo wird über den Textursampler `sampler_fc_pirata_logo` geladen. Kein Browser nötig. Die Installation ersetzt alte gleichnamige JPG-Texturen, damit keine Namenskollision entsteht.

## Bedienung
ESC Menü, Ctrl+F Vollbild, Ctrl+M Monitorwechsel, Space Preset sperren, N nächstes, R zufälliges Preset, Ctrl+I Audioquelle wechseln. Unter Linux bei Audio-Problemen `SDL_AUDIODRIVER=pulseaudio bash start-kneipen-visuals.sh` versuchen; pavucontrol kann Monitor- oder Mikrofonquelle zuweisen. Windows: Audioquelle in Settings auswählen.

## Status
Native GPU-Shader und Textur müssen auf beiden Systemen noch live getestet werden. HTML-Deck bleibt nur als optionaler Altbestand. [Upstream-Release](https://github.com/projectM-visualizer/frontend-sdl-cpp/releases/tag/2.0.0-pre1).
