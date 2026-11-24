# 🏴‍☠️🥔 Pirata Patata – Kneipen-Visuals (Ubuntu)

Ein vollautomatisches Plug-and-Play-Setup für musikreaktive Beamer-Visuals (basierend auf **projectM / MilkDrop**) für Events und Abende in der **Pirata Patata** Kneipe. 

Ohne Laser-Genehmigungen, ohne komplizierte Konfiguration: Ein Befehl richtet Software, Audio-Routing, Energiespar-Einstellungen und einen Desktop-Starter auf einem Ubuntu-Laptop ein.

---

## ⚡ Schnellinstallation (1 Befehl)

1. Öffne auf dem Ubuntu-Laptop das Terminal (**`Strg` + `Alt` + `T`**).
2. Kopiere folgende Zeile komplett hinein und drücke **Enter**:

```bash
git clone [https://github.com/MarcusGraetsch/kneipen-visuals.git](https://github.com/MarcusGraetsch/kneipen-visuals.git) && bash kneipen-visuals/setup.sh
```

*(Falls nach dem Laptop-Passwort gefragt wird: einfach blind eintippen – es erscheinen keine Sternchen – und mit **Enter** bestätigen.)*

---

## 🛠️ Was das Skript automatisch einrichtet

* **Visual-Engine & Tools:** Installiert `projectm-pulseaudio` (Visuals), `pavucontrol` (Audio-Auswahl) sowie `unclutter` (blendet den Mauszeiger nach 2 Sekunden Inaktivität automatisch aus).
* **Effekt-Vorlagen (Presets):** Richtet `~/.projectM/presets/` ein, übernimmt die System-Presets und kopiert die eigenen Presets (`Kneipen_Neon_Tunnel.milk`, `Kneipen_Bass_Puls.milk`) sowie eine vorkonfigurierte `config.inp` (60 FPS, Beat-Reaktion, weiche Übergänge).
* **Kneipen-Modus:** Deaktiviert über `gsettings` das automatische Abdunkeln und die Bildschirmsperre, damit die Projektion nicht mitten im Song ausgeht.
* **Desktop-Starter:** Legt auf dem Desktop die Verknüpfung **„Kneipen-Visuals starten“** an, die Visuals, Lautstärkeregler und Maus-Ausblender gemeinsam startet.

---

## 🎬 Ablauf am Veranstaltungsabend

1. **Beamer anschließen:** Laptop per HDMI mit dem Beamer verbinden. Unter Ubuntu unter *Einstellungen → Bildschirme* den Modus **Erweitert** wählen (nicht *Spiegeln*).
2. **Show starten:** Auf dem Desktop doppelklicken auf **„Kneipen-Visuals starten“**.
3. **Vollbild aktivieren:** Das Effekt-Fenster mit der Maus auf den Beamer-Bildschirm schieben und die Taste **`F`** drücken.
4. **Musikquelle auswählen:** Im zweiten kleinen Fenster (**Lautstärkeregler** → Reiter **Aufnahme**) rechts neben `projectM` auswählen, woher der Ton kommt:
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
├── setup.sh                      # Vollautomatisches Ubuntu-Installationsskript
├── LIESMICH_KURZANLEITUNG.txt    # Kompakte Offline-Anleitung
└── presets/                      # Eigene MilkDrop-Presets (.milk)
    ├── Kneipen_Bass_Puls.milk
    └── Kneipen_Neon_Tunnel.milk
```
