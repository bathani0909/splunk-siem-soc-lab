# Splunk SIEM SOC Lab

A hands-on multi-host SOC / SIEM lab built in VMware using **Splunk Enterprise** on **RHEL**, with **Windows Server 2025**, **Ubuntu Server**, and **Kali Linux** to simulate and investigate realistic security events.

## Project Goals
This repository documents a practical blue-team lab focused on:

- SIEM architecture and log ingestion
- Windows and Linux telemetry collection
- Attack simulation in a controlled lab
- Detection engineering in Splunk SPL
- Investigation workflows and case writeups
- Dashboard design and portfolio-ready documentation

## Lab Environment

| System | Role | IP Address |
|---|---|---:|
| RHEL | Splunk Enterprise | *Your Splunk server IP* |
| Windows Server 2025 | Windows log source / victim | `192.168.101.133` |
| Ubuntu Server | Linux log source / victim | `192.168.101.139` |
| Kali Linux | Attacker simulation host | `192.168.101.128` |

## Splunk Configuration Summary
- Splunk Enterprise installed on RHEL
- Splunk Web available on port `8000`
- Splunk receiving port `9997` enabled
- Custom index created: `windows`
- Windows Universal Forwarder installed and forwarding to Splunk
- Splunk Add-on for Microsoft Windows (TA-Windows) installed
- Ubuntu logs forwarded to Splunk
- Windows Event Logs collected:
  - Application
  - System
  - Security
  - Windows PowerShell
  - Microsoft-Windows-PowerShell/Operational

## Key Telemetry Enabled

### Windows
- Process Creation auditing (`4688`)
- Command-line visibility
- PowerShell Script Block Logging (`4104`)
- PowerShell Module Logging (`4103`)
- PowerShell transcription
- Service / task / account activity

### Ubuntu
- `/var/log/auth.log`
- SSH authentication events
- `auditd` enabled
- user / auth / sudo / shell activity

## Simulated Attack Behaviors
This repository includes safe, lab-only simulations for:

### Linux / Ubuntu
- Repeated failed SSH authentication attempts
- Invalid user enumeration
- SSH service probing
- Recon-style command attempts

### Windows
- Suspicious PowerShell execution
- Encoded PowerShell execution
- Local account creation
- Local Administrators group modification
- Scheduled task creation
- Service creation
- LOLBin execution (`certutil.exe`)
- Host / user / network reconnaissance
- Archive / collection activity

## Repository Structure
See the folder tree in this repository for detections, attack simulation scripts, dashboards, screenshots, and investigation notes.

## How to Use This Repository
1. Review the architecture and telemetry documentation.
2. Run the attack simulation scripts in the lab.
3. Validate telemetry in Splunk using the included SPL queries.
4. Review the detections and investigations.
5. Capture screenshots and place them in the referenced `screenshots/` folders.

## Screenshot Placement Guidance
When a markdown file includes screenshot placeholders like this:

### Screenshot 1 — Offense Overview
![Offense 001 Overview](../screenshots/offense-001-overview.png)

replace the file path with your actual screenshot path if needed and place the image in the matching `screenshots/` folder.

## Notes
- This project is intended for **defensive security**, **SOC portfolio development**, and **SIEM learning**.
- All attack simulations are designed for a **controlled lab environment only**.
