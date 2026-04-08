# Local User Account Creation

## Detection Title
**Local User Account Creation**

## Objective
Detect creation of a local Windows account that may indicate persistence or unauthorized access preparation.

## Environment
- **SIEM:** Splunk Enterprise
- **Host Type:** Windows Server 2025
- **Lab Scope:** Controlled VMware lab

## Data Source
- **Primary Source:** WinEventLog
- **Relevant Telemetry:** 4720 if available, 4688 process execution

## Attack Simulation Reference
- **Script:** `attack-simulation/windows/windows_offense_pack.ps1`
- **Scenario:** `LocalAccountCreation

## Detection Logic (SPL)
```spl
index=windows ("labsvcuser" OR EventCode=4720)
| table _time host EventCode source Message Process_Command_Line _raw
| sort - _time
```

## Expected Result
Evidence of local account creation for the lab user `labsvcuser`.

## Tuning / Noise Reduction Notes
Filter Splunk Universal Forwarder noise (for example `splunk-powershell.exe`) and known admin tooling. Tune for expected maintenance windows where appropriate.

## MITRE ATT&CK Mapping
- **Technique(s):** T1136.001

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
![Local User Account Creation Detection](../../screenshots/windows/local-user-account-creation-detection.png)

### Screenshot 2 — Event Details
![Local User Account Creation Event Details](../../screenshots/windows/local-user-account-creation-event-details.png)
