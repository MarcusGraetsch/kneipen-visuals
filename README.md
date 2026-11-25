# 🏴‍☠️🥔 Pirata Patata – Kneipen-Visuals

Musikreaktive Beamer-Visuals auf Ubuntu mit projectM/MilkDrop. Das Setup installiert projectM, richtet die mitgelieferten Presets ein und erstellt einen Desktop-Starter für projectM, pavucontrol und unclutter.

Ohne Laser-Genehmigungen und ohne komplizierte Konfiguration: Das Setup richtet Software, Energiespar-Einstellungen und einen Desktop-Starter auf einem Ubuntu-Laptop ein.

---

## Schnellinstallation auf Ubuntu

Öffne auf dem Ubuntu-Laptop das Terminal (**`Strg` + `Alt` + `T`**) und führe aus:

Das Repository benötigt eine grafische Ubuntu-Sitzung und eine funktionierende Audio-Sitzung. Auf Ubuntu-Versionen mit `projectm-pulseaudio` in den Paketquellen wird das Paket direkt installiert. Auf älteren Ubuntu-Versionen (einschließlich 20.04, 22.04 und 24.04) baut das Skript projectM 3.1.8 automatisch aus dem offiziellen Quellcode und installiert es nur im Home-Verzeichnis unter `~/.local/share/kneipen-visuals/`.

```bash
git clone https://github.com/MarcusGraetsch/kneipen-visuals.git
cd kneipen-visuals
bash setup.sh
```

Das Setup fragt bei Bedarf nach dem Benutzerpasswort für `sudo`. Es verändert nur die projectM-Dateien im Home-Verzeichnis, die GNOME-Energiespareinstellungen der aktuellen Sitzung und einen Desktop-Starter.

## Native Installation auf Windows

Die Windows-Variante benötigt weder WSL noch Docker. Sie lädt das offizielle native 64-Bit-`projectMSDL.exe`-Release herunter, prüft die SHA-256-Prüfsumme, kopiert die mitgelieferten Kneipen-Presets und legt die Installation unter `%LOCALAPPDATA%\Kneipen-Visuals\` ab. Der verwendete projectMSDL-Release ist aktuell als Pre-Release gekennzeichnet.

Öffne **Windows PowerShell** oder die Eingabeaufforderung im Repository-Verzeichnis und führe aus:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup-windows.ps1
```

Danach startest du die Visuals mit einem Doppelklick auf `start-kneipen-visuals-windows.cmd` oder per:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\start-kneipen-visuals-windows.ps1
```

Im projectM-Menü kannst du unter **Settings/Audio** das gewünschte Mikrofon, USB-Interface oder einen Windows-Audio-Loopback auswählen. Für den Beamer das Fenster auf den zweiten Bildschirm ziehen und `Ctrl+F` drücken.

---

## 🛠️ Was das Skript automatisch einrichtet

* **Visual-Engine & Tools:** Installiert `projectm-pulseaudio` direkt oder baut projectM 3.1.8 für ältere Ubuntu-Versionen lokal; zusätzlich werden `pavucontrol` und `unclutter` installiert.
* **Effekt-Vorlagen:** Richtet `~/.projectM/presets/` und eine vorkonfigurierte `config.inp` ein.
* **Kneipen-Modus:** Deaktiviert über `gsettings` das automatische Abdunkeln und die Bildschirmsperre, wenn eine GNOME-Sitzung verfügbar ist.
* **Desktop-Starter:** Startet Visuals, Lautstärkeregler und Maus-Ausblender über ein separates, aufräumendes Starter-Skript.

---

## 🎬 Ablauf am Veranstaltungsabend

1. **Beamer anschließen:** Laptop per HDMI mit dem Beamer verbinden. Unter Ubuntu unter *Einstellungen → Bildschirme* den Modus **Erweitern** wählen.
2. **Show starten:** Auf dem Desktop doppelklicken auf **„Kneipen-Visuals starten“**.
3. **Vollbild aktivieren:** Das Effekt-Fenster mit der Maus auf den Beamer-Bildschirm schieben und die Taste **`F`** drücken.
4. **Musikquelle auswählen:** Im zweiten kleinen Fenster (**Lautstärkeregler** → Reiter **Aufnahme**) die passende Quelle auswählen, meist eine Quelle mit der Endung `.monitor` oder ein Mikrofon/USB-Interface.
   * *Monitor of Built-in Audio* – wenn Musik/Spotify direkt auf demselben Laptop läuft.
   * *USB-Audio-Interface / Mikrofon* – wenn der Ton vom Mischpult oder aus dem Raum kommt.

---

## ⌨️ Wichtige Tastenkürzel (im Visual-Fenster)

| Taste | Funktion |
| :--- | :--- |
| **`F`** | Vollbildmodus ein- / ausschalten |
| **`N`** | Nächstes visuelles Preset laden |
| **`R`** | Zufälliges Preset laden |
| **`L`** | Aktuelles Preset sperren (kein automatischer Wechsel) |
| **`M`** | Menü / Preset-Liste ein- oder ausblenden |

---

## 💡 Praxis-Tipp für den Beamer

Stelle am Beamer den Bildmodus auf **Kino (Cinema)** oder **Dark Room**. Dadurch werden dunkle Flächen auf der Leinwand deutlich tiefer schwarz und die leuchtenden Wellenformen wirken wie frei schwebende Lichtlinien im Raum.

---

## 📂 Repository-Struktur

```text
├── setup.sh                         # Ubuntu-Installation und Konfiguration
├── setup-windows.ps1                # Native Windows-PowerShell-Installation
├── start-kneipen-visuals.sh         # Linux-Starter
├── start-kneipen-visuals-windows.ps1 # Windows-PowerShell-Starter
├── start-kneipen-visuals-windows.cmd # Windows-Doppelklick-Starter
├── LIESMICH_KURZANLEITUNG.txt       # Kompakte Offline-Anleitung
└── presets/                         # Eigene MilkDrop-Presets (.milk)
    ├── Kneipen_Bass_Puls.milk
    └── Kneipen_Neon_Tunnel.milk
```

## Fehlerbehebung

- **`projectm-pulseaudio ist nicht verfügbar`:** Auf älteren Ubuntu-Versionen baut `setup.sh` automatisch projectM 3.1.8 aus dem offiziellen Quellcode. Dafür werden Internetzugang, `git` und einige Build-Abhängigkeiten benötigt. Eine laufende grafische Sitzung ist zusätzlich erforderlich.
- **Kein Audio sichtbar:** In pavucontrol unter **Aufnahme** die passende Quelle auswählen. Bei Musik vom selben Laptop ist meist eine Quelle mit der Endung `.monitor` richtig.
- **Desktop-Starter fehlt:** `setup.sh` erneut ausführen oder `./start-kneipen-visuals.sh` im Terminal starten.
- **Windows-Installation fehlt:** `setup-windows.ps1` erneut ausführen. Die Windows-Installation benötigt ein 64-Bit-Windows und Internetzugang für den offiziellen Release-Download.
