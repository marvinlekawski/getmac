################################################
## VERSION 0.0.0.1 - Hab gekämpft wie ein Löwe.
################################################
OUTPUT_DIRECTION="/usr/home/auslesen"
OUTPUT_FILE="$OUTPUT_DIRECTION/mac-adressen.txt"
HERSTELLER_FILE="$OUTPUT_DIRECTION/hersteller.txt"

## Erstellt das Verzeichnis falls nicht vorhanden.
mkdir -p "$OUTPUT_DIRECTION"

## Prozessor-Informationen ermitteln
PROZESSOR_INFO=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^[ \t]*//')

## Datei initialisieren mit Tabellenkopf
{
echo "+-------------------+----------------+------------------------------------+"
echo "| MAC-Adresse      | Hersteller     | Prozessor                          |"
echo "+-------------------+----------------+------------------------------------+"
} > "$OUTPUT_FILE"

## IP-Subnetze automatisch ermitteln
IPSUBNETZEUNDSO=$(ip -o -f inet addr show | awk '{print $4}' | cut -d/ -f1 | sed 's/\.[0-9]*$/\.0\/24/') 

## Überprüfen, ob nmap installiert ist
if ! command -v nmap &> /dev/null; then
    echo "nmap könnte nicht gefunden werden. Installation wird gestartet..." >> "$OUTPUT_FILE"
    sudo apt update && sudo apt install -y nmap && sudo apt upgrade
    if [ $? -ne 0 ]; then
        echo "Fehler bei der Installation von nmap." >> "$OUTPUT_FILE"
        exit 1
    fi
fi

## Prüfen, ob Hersteller-Datei existiert
if [ ! -f "$HERSTELLER_FILE" ]; then
    echo "Die Datei hersteller.txt wurde nicht gefunden!" >> "$OUTPUT_FILE"
    exit 1
fi

## NMAP-Scan durchführen
for SUBNET in $IPSUBNETZEUNDSO; do
    nmap -sP "$SUBNET" | awk '/MAC Address/ {print $3}' | sort -u | grep -v "^$" | while read -r MAC; do
        
        ## MAC-Adress-Präfix für Herstellerbestimmung
        MAC_ADRESSE_PR=$(echo "$MAC" | cut -d: -f1-3 | tr -d ':')  
        
        ## Hersteller aus Datei auslesen
        HERSTELLER=$(grep -i "^$MAC_ADRESSE_PR" "$HERSTELLER_FILE" | awk '{print $2}')
        if [ -z "$HERSTELLER" ]; then
            HERSTELLER="Unbekannt"
        fi

        ## Eintrag zur Tabelle hinzufügen
        printf "| %-17s | %-14s | %-34s |\n" "$MAC" "$HERSTELLER" "$PROZESSOR_INFO" >> "$OUTPUT_FILE"
    done
done

## Tabellenende hinzufügen
echo "+-------------------+----------------+------------------------------------+" >> "$OUTPUT_FILE"

## Abschlussmeldung
echo "Gespeichert unter: $OUTPUT_FILE"
