# Suspicious PowerShell Execution

## Detection Title
**Suspicious PowerShell Execution**

## Objective
Detect suspicious PowerShell usage involving discovery-oriented commands and bypass-style execution.

## Environment
- **SIEM:** Splunk Enterprise
- **Host Type:** Windows Server 2025
- **Lab Scope:** Controlled VMware lab

## Data Source
- **Primary Source:** WinEventLog
- **Relevant Telemetry:** 4688, 4103, 4104; PowerShell command lines and script blocks

## Attack Simulation Reference
- **Script:** `attack-simulation/windows/windows_offense_pack.ps1`
- **Scenario:** `SuspiciousPowerShell

## Detection Logic (SPL)
```spl
index=windows (EventCode=4103 OR EventCode=4104 OR EventCode=4688)
("Get-LocalUser" OR "Get-Process" OR "ExecutionPolicy Bypass")
NOT New_Process_Name="*splunk-powershell.exe"
NOT Process_Command_Line="*splunk-powershell.exe*"
| table _time host EventCode New_Process_Name Process_Command_Line ScriptBlockText Message
| sort - _time
```

## Expected Result
PowerShell activity showing discovery commands and/or bypass-style execution from the Windows offense framework.

## Tuning / Noise Reduction Notes
Filter Splunk Universal Forwarder noise (for example `splunk-powershell.exe`) and known admin tooling. Tune for expected maintenance windows where appropriate.

## MITRE ATT&CK Mapping
- **Technique(s):** T1059.001

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
![Suspicious PowerShell Execution Detection](../../screenshots/windows/suspicious-powershell-execution-detection.png)

### Screenshot 2 — Event Details
![Suspicious PowerShell Execution Event Details](../../screenshots/windows/suspicious-powershell-execution-event-details.png)
