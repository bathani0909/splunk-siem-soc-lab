# Windows Recon Commands

## Detection Title
**Windows Recon Commands**

## Objective
Detect discovery-oriented commands that enumerate system, user, and network information.

## Environment
- **SIEM:** Splunk Enterprise
- **Host Type:** Windows Server 2025
- **Lab Scope:** Controlled VMware lab

## Data Source
- **Primary Source:** WinEventLog
- **Relevant Telemetry:** 4688, 4103, 4104

## Attack Simulation Reference
- **Script:** `attack-simulation/windows/windows_offense_pack.ps1`
- **Scenario:** `ReconCommands

## Detection Logic (SPL)
```spl
index=windows EventCode=4688 ("whoami" OR "ipconfig" OR "systeminfo" OR "tasklist" OR "net user" OR "net localgroup")
| table _time host New_Process_Name Process_Command_Line Parent_Process_Name
| sort - _time
```

## Expected Result
Reconnaissance commands executed locally on the Windows host.

## Tuning / Noise Reduction Notes
Filter Splunk Universal Forwarder noise (for example `splunk-powershell.exe`) and known admin tooling. Tune for expected maintenance windows where appropriate.

## MITRE ATT&CK Mapping
- **Technique(s):** T1082 / T1016 / T1033 / T1087

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
![Windows Recon Commands Detection](../../screenshots/windows/windows-recon-commands-detection.png)

### Screenshot 2 — Event Details
![Windows Recon Commands Event Details](../../screenshots/windows/windows-recon-commands-event-details.png)
