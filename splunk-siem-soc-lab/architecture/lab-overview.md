# Lab Overview

## Objective
Build a practical SOC / SIEM lab to generate, detect, and investigate realistic Windows and Linux security telemetry using Splunk.

## Environment Summary
- **SIEM:** Splunk Enterprise on RHEL
- **Windows Victim:** Windows Server 2025 (`192.168.101.133`)
- **Linux Victim:** Ubuntu Server (`192.168.101.139`)
- **Attacker:** Kali Linux (`192.168.101.128`)

## Data Flow
1. Windows Server forwards event logs to Splunk using Splunk Universal Forwarder.
2. Ubuntu forwards logs to Splunk.
3. Kali is used to generate controlled attack-like activity against Ubuntu and to support the overall lab workflow.
4. Windows also runs local simulation scripts to generate high-quality Windows telemetry.

## Key Detection Goals
- Authentication abuse
- PowerShell misuse
- Persistence indicators
- Living-off-the-land binary usage
- User / group / service / task changes
- Reconnaissance activity

## Screenshot Placement
### Screenshot 1 — Lab Architecture
![Lab Architecture](../screenshots/windows/lab-architecture.png)

### Screenshot 2 — Splunk Search Head
![Splunk Search Head](../screenshots/windows/splunk-search-head.png)
