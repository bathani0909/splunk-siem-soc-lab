# Local Administrators Group Modification

## Detection Title
**Local Administrators Group Modification**

## Objective
Detect addition of a user to the local Administrators group.

## Environment
- **SIEM:** Splunk Enterprise
- **Host Type:** Windows Server 2025
- **Lab Scope:** Controlled VMware lab

## Data Source
- **Primary Source:** WinEventLog
- **Relevant Telemetry:** 4732 if available, 4688 process execution

## Attack Simulation Reference
- **Script:** `attack-simulation/windows/windows_offense_pack.ps1`
- **Scenario:** `LocalAdminGroupChange

## Detection Logic (SPL)
```spl
index=windows ("Administrators" AND "labsvcuser")
| table _time host EventCode source Message Process_Command_Line _raw
| sort - _time
```

## Expected Result
Evidence that `labsvcuser` was added to the local Administrators group.

## Tuning / Noise Reduction Notes
Filter Splunk Universal Forwarder noise (for example `splunk-powershell.exe`) and known admin tooling. Tune for expected maintenance windows where appropriate.

## MITRE ATT&CK Mapping
- **Technique(s):** T1098 / T1078

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
![Local Administrators Group Modification Detection](../../screenshots/windows/local-admin-group-modification-detection.png)

### Screenshot 2 — Event Details
![Local Administrators Group Modification Event Details](../../screenshots/windows/local-admin-group-modification-event-details.png)
