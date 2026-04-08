
---

# lab-overview.md

# Lab Overview

## Objective

This lab was built to simulate a small SOC environment using Splunk Enterprise as the central SIEM platform. The purpose of the lab is to collect host telemetry from Windows and Linux systems, generate realistic attack-like activity, validate event visibility, and develop detections and investigations based on observed security events.

---

## Lab Systems

- **SIEM:** Splunk Enterprise on RHEL
- **Windows Victim:** Windows Server 2025 (`192.168.101.133`)
- **Linux Victim:** Ubuntu Server (`192.168.101.139`)
- **Attacker:** Kali Linux (`192.168.101.128`)

---

## Roles of Each System

### Splunk Server
The Splunk instance acts as the central logging and analysis platform. It receives forwarded events from both Windows and Ubuntu and is used to validate telemetry, run SPL searches, build detections, and review investigation evidence.

### Windows Server
The Windows host is used to generate and forward key Windows security telemetry such as process creation, PowerShell logging, account changes, scheduled tasks, and service creation.

### Ubuntu Server
The Ubuntu host is used to generate and forward Linux authentication and SSH-related telemetry, including failed authentication attempts, invalid user enumeration, and related login activity.

### Kali Linux
The Kali host is used to simulate controlled attacker behavior such as SSH brute-force attempts, invalid username enumeration, and general hostile activity to generate realistic events in the lab.

---

## Data Flow

1. Windows Server forwards event logs to Splunk using Splunk Universal Forwarder.
2. Ubuntu forwards Linux authentication and system logs to Splunk.
3. Kali is used to generate controlled attack-like activity against Ubuntu.
4. Windows also runs local simulation commands and scripts to generate security-relevant telemetry.

---

## Key Detection Goals

This lab focuses on validating and detecting the following types of activity:

- Authentication abuse
- PowerShell misuse
- Persistence indicators
- Living-off-the-land binary usage
- User / group / service / task changes
- Reconnaissance activity

---

## Validation Approach

Each data source and detection in this lab is validated using:

- Known test activity
- Splunk SPL searches
- Security event review
- Screenshot-based evidence

The goal is to ensure that the detections are not theoretical only, but are tied to actual observed telemetry inside the lab.

---

## Screenshot Placement

### Screenshot 1 — Lab Architecture
![Lab Architecture](../screenshots/lab-architecture.png)

### Screenshot 2 — Splunk Search Head
![Splunk Search Head](../screenshots/splunk-search-head.png)
