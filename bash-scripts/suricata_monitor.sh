#Suricata Service Monitor (Auto-Restart if Down)

#!/bin/bash

SERVICE="suricata"

if ! systemctl is-active --quiet $SERVICE; then
	echo " [!] Suricata is down Restarting..."
	systemctl restart $SERVICE
	echo "[+] Suricata started at $(date)"
else
	echo "[✓] Suricata is running"
	systemctl status $SERVICE
fi
