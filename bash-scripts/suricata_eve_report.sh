#!/usr/bin/env bash

# Exit immediately if something goes wrong
set -o errexit
set -o pipefail
set -o nounset

EVE_LOG="/var/log/suricata/eve.json"
REPORT_FILE="$HOME/suricata_alert_report.txt"
ALERT_LIMIT=20

# ANSI colors (Bash safe)
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
RESET="\e[0m"

DIVIDER="-------------------------------------------------------------"

# Safety check
if [[ ! -f "$EVE_LOG" ]]; then
    echo "[!] eve.json not found at $EVE_LOG"
    exit 1
fi

echo "Generating Suricata alert report..."
echo "Report saved to: $REPORT_FILE"
echo

# Terminal header
echo "==================== SURICATA ALERT VIEW ===================="
echo "Time                | Sev | Proto | Source → Destination"
echo "$DIVIDER"

# File header
{
    echo "==================== SURICATA ALERT REPORT ===================="
    echo "Time                | Sev | Proto | Source → Destination"
    echo "$DIVIDER"
} > "$REPORT_FILE"

jq -r '
select(.event_type=="alert" or .event_type=="drop") |
[
  .timestamp,
  (.alert.severity // 3 | tostring),
  .proto,
  (.src_ip + " → " + .dest_ip),
  (.alert.signature // .drop.reason // "N/A"),
  (.alert.category // "N/A")
] | @tsv
' "$EVE_LOG" | tail -n "$ALERT_LIMIT" |
while IFS=$'\t' read -r time sev proto flow sig cat; do

    # Severity-based coloring
    if [[ "$sev" == "1" ]]; then
        COLOR="$RED"
    elif [[ "$sev" == "2" ]]; then
        COLOR="$YELLOW"
    else
        COLOR="$GREEN"
    fi

    # Terminal output (colored)
    echo -e "${COLOR}${time} | ${sev} | ${proto} | ${flow}${RESET}"
    echo "  ↳ $sig"
    echo "  ↳ Category: $cat"
    echo "$DIVIDER"

    # File output (plain text)
    {
        echo "${time} | ${sev} | ${proto} | ${flow}"
        echo "  -> $sig"
        echo "  -> Category: $cat"
        echo "$DIVIDER"
    } >> "$REPORT_FILE"

done


