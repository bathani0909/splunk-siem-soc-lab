# Windows Telemetry

## Host
- **Hostname:** WS-25
- **IP:** `192.168.101.133`

## Log Sources
- `WinEventLog:Application`
- `WinEventLog:System`
- `WinEventLog:Security`
- `WinEventLog:Windows PowerShell`
- `WinEventLog:Microsoft-Windows-PowerShell/Operational`

## Logging Enhancements Enabled
- Process Creation Auditing
- Process Command Line Inclusion
- PowerShell Script Block Logging
- PowerShell Module Logging
- PowerShell Transcription

## Important Event IDs

| Event ID | Description | Why It Matters |
|---|---|---|
| 4688 | Process creation | Process execution and command-line visibility |
| 4103 | PowerShell Module Logging | Cmdlet / module usage |
| 4104 | PowerShell Script Block Logging | Script content visibility |
| 4720 | User account created | Persistence / unauthorized account creation |
| 4732 | Member added to local group | Privilege escalation / admin group changes |

## Validation SPL
```spl
index=windows (EventCode=4688 OR EventCode=4103 OR EventCode=4104)
| stats count by EventCode source
| sort - count
```

## Screenshot Placement
### Screenshot 1 — Windows Telemetry Validation
![Windows Telemetry Validation](screenshots/windows/windows-telemetry-validation.png)
