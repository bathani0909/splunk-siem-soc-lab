# Ubuntu Telemetry

## Host
- **Hostname:** ubuntu
- **IP:** `192.168.101.139`

## Important Log Sources
- `/var/log/auth.log`
- `auditd`

## Logging Goals
- SSH authentication attempts
- Invalid user enumeration
- Authentication failures
- Sudo / privilege activity
- User management
- Shell execution visibility (where available)

## Key Linux Behaviors Observed
- Failed password attempts from Kali (`192.168.101.128`)
- Invalid SSH usernames
- SSH connection attempts and closures
- Authentication failure bursts

## Validation SPL
```spl
index=* source="/var/log/auth.log" "192.168.101.128"
| table _time host _raw
| sort - _time
```

## Screenshot 
### Ubuntu Auth Log Activity

![Ubuntu Auth Activity](screenshots/linux/ubuntu-auth-activity.png)
