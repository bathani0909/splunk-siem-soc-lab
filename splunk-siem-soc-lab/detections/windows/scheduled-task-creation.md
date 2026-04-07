# Scheduled Task Creation

## Detection Title
**Scheduled Task Creation**

## Objective
Detect creation of a scheduled task used as a persistence or execution mechanism.

## Environment
- **SIEM:** Splunk Enterprise
- **Host Type:** Windows Server 2025
- **Lab Scope:** Controlled VMware lab

## Data Source
- **Primary Source:** WinEventLog
- **Relevant Telemetry:** 4688 process creation and task-related logs

## Attack Simulation Reference
- **Script:** `attack-simulation/windows/windows_offense_pack.ps1`
- **Scenario:** `ScheduledTaskCreation

## Detection Logic (SPL)
```spl
index=windows "LabUpdateTask"
| table _time host EventCode source Process_Command_Line _raw
| sort - _time
```

## Expected Result
Task creation telemetry for `LabUpdateTask`.

## Tuning / Noise Reduction Notes
Filter Splunk Universal Forwarder noise (for example `splunk-powershell.exe`) and known admin tooling. Tune for expected maintenance windows where appropriate.

## MITRE ATT&CK Mapping
- **Technique(s):** T1053.005

## Analyst Triage Notes
Validate the user context, parent process, command line, and related host activity. Pivot around the event to identify preceding and follow-on actions.

## Investigation Steps
1. Validate source host and timestamp.
2. Review parent/child process or auth chain.
3. Identify account used and command / behavior observed.
4. Pivot to surrounding events ±15 minutes.
5. Determine if the activity was expected administrative behavior or suspicious lab-generated behavior.

## Screenshot Placement
### Screenshot 1 — Detection Search Results
![Scheduled Task Creation Detection](../../screenshots/windows/scheduled-task-creation-detection.png)

### Screenshot 2 — Event Details
![Scheduled Task Creation Event Details](../../screenshots/windows/scheduled-task-creation-event-details.png)
