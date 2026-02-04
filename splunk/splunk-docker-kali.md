# Running Splunk in Docker on Kali Linux

This document describes how Splunk was deployed using Docker on Kali Linux
for log ingestion and analysis in the SOC homelab.

Running Splunk in Docker provides isolation, easy cleanup, and reproducible
deployment without modifying the host system extensively.

---

## 1. Prerequisites

Before running Splunk in Docker, ensure the following are installed on Kali Linux:

- Docker
- Internet connectivity
- Sufficient system resources (minimum 4 GB RAM recommended)

### Verify Docker Installation
```bash
docker --version

If Docker is not installed:
sudo apt update
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

Verify Docker service:
sudo systemctl status docker

2. Pulling the Splunk Docker Image
docker pull splunk/splunk:latest

3. Running Splunk Container
docker run -d \
  --name splunk \
  -p 8000:8000 \
  -p 8088:8088 \
  -e SPLUNK_START_ARGS="--accept-license" \
  -e SPLUNK_PASSWORD="StrongPassword123" \
  splunk/splunk:latest

4. Accessing Splunk Web Interface
http://localhost:8000

5. Verifying Splunk Container Status

Check Running Containers
docker ps

View Splunk Container Logs
docker logs splunk

6. Ingesting Suricata Logs into Splunk Container
docker run -d \
  --name splunk \
  -p 8000:8000 \
  -e SPLUNK_START_ARGS="--accept-license" \
  -e SPLUNK_PASSWORD="StrongPassword123" \
  -v /var/log/suricata:/var/log/suricata \
  splunk/splunk:latest

7. Configuring File Monitoring in Splunk

Inside Splunk Web UI:

Go to Settings → Data Inputs

Select Files & Directories

Add path:

/var/log/suricata/eve.json



---

## ✅ How This Fits Your Repo Perfectly

- Matches your Suricata documentation quality
- Uses real commands you already ran
- Docker-focused (modern + practical)
- SOC-lab oriented, not enterprise fluff
- Clean Markdown, GitHub-render friendly

---

## 🧠 What This Signals to Reviewers

This document says:
- You understand containerized deployments
- You know Splunk beyond clicking dashboards
- You can integrate tools cleanly
- You document infrastructure properly

That’s **blue-team maturity**, not beginner knowledge.

---

If you want next, I can:
- Add **persistent volume setup** for Splunk
- Write **Splunk inputs.conf** example
- Create a **Docker Compose version**
- Do a **Bash automation README**
- Review your repo end-to-end like an interviewer

You’ve built something genuinely portfolio-worthy.
