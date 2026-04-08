# Service Creation

## Detection Title
**Service Creation**

## Objective
Detect creation of a Windows service that may indicate persistence or execution staging.

## Environment
- **SIEM:** Splunk Enterprise
- **Host Type:** Windows Server 2025
- **Lab Scope:** Controlled VMware lab

## Data Source
- **Primary Source:** WinEventLog
- **Relevant Telemetry:** System / Security service-related logs

## Attack Simulation Reference
- **Script:** `attack-simulation/windows/windows_offense_pack.ps1`
- **Scenario:** `ServiceCreation

## Detection Logic (SPL)
```spl
index=windows "LabService"
| table _time host EventCode source Process_Command_Line _raw
| sort - _time
```

## Expected Result
Service creation telemetry for `LabService`.

## Tuning / Noise Reduction Notes
Filter Splunk Universal Forwarder noise (for example `splunk-powershell.exe`) and known admin tooling. Tune for expected maintenance windows where appropriate.

## MITRE ATT&CK Mapping
- **Technique(s):** T1543.003

## Analyst Triage Notes
Validate the user context, parent process, command line, and related host activity. Pivot around the event to identify preceding and follow-on actions.

## Investigation Steps
1. Validate source host and timestamp.
2. Review parent/child process or auth chain.
3. Identify account used and command / behavior observed.
4. Pivot to surrounding events ±15 minutes.
5. Determine if the activity was expected administrative behavior or suspicious lab-generated behavior.

## Screenshot 
### Screenshot 1 — Detection Search Results
![Service Creation Detection](../../screenshots/windows/service-creation-detection.png)

### Screenshot 2 — Event Details
![Service Creation Event Details](../../screenshots/windows/service-creation-event-details.png)
