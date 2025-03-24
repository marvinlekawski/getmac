# 🖧 getmac.sh

Ein Shell-Script zum Auslesen von MAC-Adressen und Zuordnung der Hersteller anhand einer lokalen Datei (`hersteller.txt`).

---

## 📥 How-to: Installation und Nutzung des Scripts

---

### 🔧 1. Script in das gewünschte Verzeichnis kopieren

#### 📝 Möglichkeit 1: Mit Notepad++ (Copy & Paste)

1. Öffne **Notepad++**
2. Erstelle eine neue Datei → `Datei` → `Neu`
3. Kopiere den Inhalt des Scripts hinein
4. Speichere die Datei als `getmac.sh` → `Datei` → `Speichern unter`
5. Übertrage die Datei auf den Server (z. B. mit **WinSCP**)

#### 🖥️ Möglichkeit 2: Direkt mit `nano` im Terminal

```bash
cd /usr/home/
nano getmac.sh
```

> Füge den Script-Inhalt ein und speichere mit `Strg + X`, dann `Y` und `Enter`.

Anschließend ausführbar machen:

```bash
chmod +x getmac.sh
```

#### 📂 Möglichkeit 3: Mit WinSCP

1. Öffne **WinSCP** und verbinde dich mit dem Server
2. Navigiere rechts zum gewünschten Verzeichnis (z. B. `/usr/home/`)
3. Ziehe die Datei `getmac.sh` vom lokalen PC in das Remote-Verzeichnis
4. Falls nötig, Rechte anpassen:

```bash
chmod +x /usr/home/getmac.sh
```

---

### 📁 2. Pfad `/usr/home/auslesen/` erstellen

Falls du den Pfad **nicht manuell** anlegen möchtest, reicht es, das Script auszuführen:

```bash
./getmac.sh
```

Alternativ manuell anlegen:

```bash
mkdir -p /usr/home/auslesen/
```

---

### 📄 3. Datei `hersteller.txt` hinzufügen

#### 📝 Möglichkeit 1: Mit Notepad++

1. Öffne **Notepad++**
2. Erstelle eine neue Datei
3. Füge die gewünschten Inhalte ein
4. Speichere als `hersteller.txt`
5. Übertrage die Datei auf den Server (z. B. mit **WinSCP**)

#### 🖥️ Möglichkeit 2: Mit `nano` im Terminal

```bash
nano /usr/home/auslesen/hersteller.txt
```

> Inhalt einfügen und mit `Strg + X`, dann `Y`, dann `Enter` speichern.

#### 📂 Möglichkeit 3: Mit WinSCP

1. Navigiere in `/usr/home/auslesen/`
2. Ziehe `hersteller.txt` vom PC ins Verzeichnis

---

### 🚀 4. Script ausführen

```bash
/usr/home/getmac.sh
```

Falls es nicht funktioniert, prüfe, ob das Script ausführbar ist:

```bash
chmod +x /usr/home/getmac.sh
```

✅ **Fertig!**

Das Script ist nun installiert.

Die Datei `hersteller.txt` findest du auch online hier:
[gist.githubusercontent.com (mac-vendor.txt)](https://gist.githubusercontent.com/aallan/b4bb86db86079509e6159810ae9bd3e4/raw/846ae1b646ab0f4d646af9115e47365f4118e5f6/mac-vendor.txt)

---

## 💡 Optional: Git verwenden

Falls du das Projekt via Git klonen möchtest:

```bash
apt update && apt install git -y
git clone https://github.com/marvinlekawski/getmac.git
```

---

Have fun!
