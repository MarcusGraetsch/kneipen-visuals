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

## Detaillierte Bedienungsanleitung: Ubuntu

1. `bash setup.sh` ausführen und danach `bash start-kneipen-visuals.sh` starten.
2. In `pavucontrol` den Reiter **Aufnahme** öffnen und als Quelle den Monitor-Ausgang der gewünschten Wiedergabe oder ein Mikrofon/USB-Audiointerface auswählen.
3. In projectM mit `Strg+B` Menü und Statusleiste einblenden. Danach **File → Add Presets** wählen und im geklonten Repository den Ordner `presets` öffnen.
4. `Kneipen_Bass_Puls.milk` oder `Kneipen_Neon_Tunnel.milk` markieren und laden. In der Playlist den Eintrag anklicken; per Rechtsklick stehen **Hard cut to this preset** und **Soft cut to this preset** zur Verfügung. Ein Doppelklick auf den Playlist-Eintrag lädt es ebenfalls.
5. Mit `Strg+L` das gewählte Preset sperren. Mit `Strg+F` auf Vollbild für den Beamer schalten.

Wichtige Ubuntu-Tasten: `Strg+N` nächstes Preset, `Strg+P` vorheriges Preset, `Strg+R` zufälliges Preset, `Strg+Y` Shuffle, `Strg+M` Menü/Anzeige, `Strg+E` Editor, `Strg+S` Editor-Änderungen speichern, `Esc` Overlay schließen. Das Setup kopiert die beiden Repository-Presets zusätzlich nach `~/.projectM/presets/`; sie stehen nach späteren Starts daher auch in der normalen Playlist zur Verfügung.

## Detaillierte Bedienungsanleitung: Windows

1. `setup-windows.ps1` aus PowerShell ausführen und anschließend `start-kneipen-visuals-windows.cmd` starten. Das ist eine native Windows-Ausführung, kein WSL.
2. Falls kein Ton reagiert: `Esc` drücken, **Settings → Audio** öffnen und Mikrofon, USB-Interface oder den passenden Windows-Loopback-Eingang wählen. Danach in das Visualisierungsfenster klicken, damit es den Tastaturfokus hat.
3. Für ein Repository-Preset den Windows-Explorer im geklonten Ordner `kneipen-visuals\presets` öffnen. `Kneipen_Bass_Puls.milk` oder `Kneipen_Neon_Tunnel.milk` mit der Maus auf das laufende projectM-Fenster ziehen und dort loslassen. Ein einzelnes Preset wird sofort geladen; anschließend mit der Leertaste sperren.
4. Der komplette Ordner `presets` kann ebenfalls auf das projectM-Fenster gezogen werden. Dadurch wird er für die aktuelle Sitzung als Playlist ergänzt; das zuletzt geladene Preset wird nicht automatisch gewechselt.

Wichtige Windows-Tasten: `Esc` Menü ein/aus, `N` nächstes Preset, `Shift+N` nächstes Preset mit weichem Übergang, `P` vorheriges, `Shift+P` weich vorheriges, `R` zufälliges Preset, `Shift+R` weicher Zufallswechsel, `Backspace` Wiedergabeverlauf zurück, `Leertaste` Preset sperren/entsperren, `Y` Shuffle, `Strg+F` Vollbild, `Strg+I` Audioquelle wechseln, `Strg+M` Fenster auf anderen Monitor verschieben, `Strg+Q` beenden.

## Status
Native GPU-Shader und Textur müssen auf beiden Systemen noch live getestet werden. HTML-Deck bleibt nur als optionaler Altbestand. [Upstream-Release](https://github.com/projectM-visualizer/frontend-sdl-cpp/releases/tag/2.0.0-pre1).

## Pirata 3D Collection

- Pirata_3D_Electric: blau-weisse perspektivische Drehung und elektrische Entladungen.
- Pirata_Crimson_Eye: rotes Auge, langsame Raumrotation und goldene Akzente.
- Pirata_Acid_Storm: gruene und violette Entladungen, schnellere Raumrotation.

Nach git pull Setup erneut ausführen. Die Starter setzen explizite Preset-/Texturpfade. Windows Einzeltest: `powershell -NoProfile -ExecutionPolicy Bypass -File .\start-kneipen-visuals-windows.ps1 -Preset Pirata_3D_Electric`. Die Blitze sind lokal begrenzt, keine Vollbild-Stroboskope. Die Bass-/Treble-Transienten sind eine Annäherung an den Beat, keine BPM-Synchronisation. GPU- und Audio-Test ausstehend.

## Pirata Volumetric Skull

`Pirata_Volumetric_Skull.milk` ist ein prozedurales 3D-SDF-Modell (Raymarching im MilkDrop-Composite-Shader, Shader Model 3). Ein massiver Totenkopf mit ausgeschnittenen Augenhöhlen, Kiefer, Zähnen, leuchtendem Auge und räumlichem Stachelring rotiert im Raum. Das Original-PNG dient als rückseitige Oberflächentextur. Kein importiertes Mesh; stilisierte Annäherung an das Logo. Lokale musikreaktive Blitze, kein Vollbild-Stroboskop. Bis zu 72 Raymarch-Schritte pro Pixel; GPU-Kompatibilität und FPS vor Einsatz prüfen. Bei Bedarf ein anderes Preset wählen oder die Fensterauflösung senken.

Windows Einzeltest: `powershell -NoProfile -ExecutionPolicy Bypass -File .\start-kneipen-visuals-windows.ps1 -Preset Pirata_Volumetric_Skull`
