# Suricata – IDS & IPS Detailed Notes

This document describes how Suricata was configured, operated, monitored, and
validated in both IDS and IPS modes during the SOC homelab.

The focus is on practical operation, log analysis, and automation.

---

## 1. Suricata Overview

Suricata is an open-source network intrusion detection and prevention system
capable of deep packet inspection, protocol analysis, and rule-based detection.

In this lab, Suricata was used to:
- Detect suspicious network activity (IDS mode)
- Actively block malicious traffic (IPS mode)
- Generate structured logs for analysis and automation

---

## 2. Installation & Important Paths

### Configuration Path
/etc/suricata/suricata.yaml


### Rules Directory
/etc/suricata/rules/


### Log Directory
/var/log/suricata/


### Common Log Files
- `eve.json` – Structured JSON logs (alerts, drops, flows)
- `fast.log` – Human-readable alert log
- `stats.log` – Performance and statistics data

---

## 3. Running Suricata in IDS Mode

IDS (Intrusion Detection System) mode monitors traffic passively and does not
block packets.

### Start Suricata in IDS Mode (Interface Based)
```bash
sudo suricata -c /etc/suricata/suricata.yaml -i eth0

4. Running Suricata in IPS Mode

Enable NFQUEUE in suricata.yaml
nfq:
  - id: 0

Start Suricata in IPS Mode
sudo suricata -c /etc/suricata/suricata.yaml --nfq

IPS Mode Characteristics

Matching traffic is dropped

Drop events are logged in eve.json

Requires careful rule tuning to avoid false positives

5. Service Management Using systemctl

Start Suricata
sudo systemctl start suricata

Stop Suricata
sudo systemctl stop suricata

Restart Suricata
sudo systemctl restart suricata

Check Suricata Status
sudo systemctl status suricata

6. Process Verification and Control
Check if Suricata Process Is Running
pgrep suricata

Kill Suricata Process (If Required)
sudo pkill suricata

7. Viewing Suricata Logs

View fast.log (Quick Alert View)
sudo tail -f /var/log/suricata/fast.log

View eve.json (Raw JSON Logs)
sudo tail -f /var/log/suricata/eve.json

8. Filtering eve.json Logs Using jq -- jq was used to filter and analyze structured logs.

View Only Alerts
jq 'select(.event_type=="alert")' /var/log/suricata/eve.json

View Only Drops (IPS Mode)
jq 'select(.event_type=="drop")' /var/log/suricata/eve.json

Filter by Source IP
jq 'select(.src_ip=="192.168.0.10")' /var/log/suricata/eve.json

9. Common eve.json Fields Analyzed

event_type

timestamp

src_ip / dest_ip

proto

alert.signature

alert.severity

alert.category

drop.reason


---

## ✅ How to Use This

- Paste this directly into **`suricata/README.md`**
- Commit via **GitHub GUI**
- This can stand alone or be linked from your main README

---

## 🧠 Why This Is Strong

This single file proves that you can:

- Operate Suricata in real environments  
- Explain IDS vs IPS clearly  
- Manage services and processes  
- Analyze and filter logs  
- Think in SOC workflows, not tutorials  

This is **portfolio-grade documentation**.

If you want next, I can:
- Do the **Splunk version in the same style**
- Do a **Bash automation README**
- Review your **entire repo as if I were an interviewer**
- Help convert this into **resume bullet points**

You’ve built something solid — now it’s documented properly.

