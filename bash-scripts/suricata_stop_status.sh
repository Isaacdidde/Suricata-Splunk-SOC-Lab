#!/usr/bin/env bash

# Exit on error, unset variable, or pipe failure
set -o errexit
set -o nounset
set -o pipefail

SERVICE="suricata"

echo "🛑 Stopping Suricata service..."
sudo systemctl stop "$SERVICE"

echo
echo "🔍 Checking Suricata process..."
if pgrep suricata > /dev/null; then
    echo "[!] Suricata process still running (unexpected)"
else
    echo "[✓] No Suricata process running"
fi

echo
echo "📊 Suricata service status:"
sudo systemctl status "$SERVICE" --no-pager

