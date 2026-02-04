#IDS ↔ IPS Mode Switcher

#!/bin/bash

CONFIG="/etc/suricata/suricata.yaml"

echo "1) IDS Mode"
echo "2) IPS Mode"
read -p "Choose mode: " MODE

if [ "$MODE" = "1" ]; then
    sed -i 's/^ *- nfq/#- nfq/' "$CONFIG"
    systemctl restart suricata
    echo "[✓] Switched to IDS mode"

elif [ "$MODE" = "2" ]; then
    sed -i 's/^# *- nfq/- nfq/' "$CONFIG"
    systemctl restart suricata
    echo "[✓] Switched to IPS mode"

else
    echo "[!] Invalid option"
fi

