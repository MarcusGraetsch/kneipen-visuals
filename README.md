# 🏴‍☠️🥔 Pirata Patata – Kneipen-Visuals

Musikreaktive Beamer-Visuals auf Ubuntu mit projectM/MilkDrop. Das Setup installiert projectM, richtet die mitgelieferten Presets ein und erstellt einen Desktop-Starter für projectM, pavucontrol und unclutter.

Ohne Laser-Genehmigungen und ohne komplizierte Konfiguration: Das Setup richtet Software, Energiespar-Einstellungen und einen Desktop-Starter auf einem Ubuntu-Laptop ein.

---

## Schnellinstallation auf Ubuntu

Öffne auf dem Ubuntu-Laptop das Terminal (**`Strg` + `Alt` + `T`**) und führe aus:

Das Repository benötigt eine grafische Ubuntu-Sitzung und eine funktionierende Audio-Sitzung. Der aktuell benötigte Ubuntu-Paketname `projectm-pulseaudio` ist in den Standardquellen derzeit ab Ubuntu 26.10 verfügbar; auf Ubuntu 22.04/24.04 bricht das Skript bewusst mit einer verständlichen Meldung ab, statt eine unvollständige Installation vorzunehmen.

```bash
git clone https://github.com/MarcusGraetsch/kneipen-visuals.git
cd kneipen-visuals
bash setup.sh
```

Das Setup fragt bei Bedarf nach dem Benutzerpasswort für `sudo`. Es verändert nur die projectM-Dateien im Home-Verzeichnis, die GNOME-Energiespareinstellungen der aktuellen Sitzung und einen Desktop-Starter.

---

## 🛠️ Was das Skript automatisch einrichtet

* **Visual-Engine & Tools:** Installiert `projectm-pulseaudio`, `pavucontrol` und `unclutter`.
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
├── start-kneipen-visuals.sh         # Robuster Desktop-/Terminal-Starter
├── LIESMICH_KURZANLEITUNG.txt       # Kompakte Offline-Anleitung
└── presets/                         # Eigene MilkDrop-Presets (.milk)
    ├── Kneipen_Bass_Puls.milk
    └── Kneipen_Neon_Tunnel.milk
```

## Fehlerbehebung

- **`projectm-pulseaudio ist nicht verfügbar`:** Das Setup unterstützt derzeit Ubuntu 26.10 oder neuer mit aktivierter `universe`-Quelle. Eine laufende grafische Sitzung ist zusätzlich erforderlich.
- **Kein Audio sichtbar:** In pavucontrol unter **Aufnahme** die passende Quelle auswählen. Bei Musik vom selben Laptop ist meist eine Quelle mit der Endung `.monitor` richtig.
- **Desktop-Starter fehlt:** `setup.sh` erneut ausführen oder `./start-kneipen-visuals.sh` im Terminal starten.
