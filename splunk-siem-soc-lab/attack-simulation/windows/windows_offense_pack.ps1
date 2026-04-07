param(
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        "SuspiciousPowerShell","EncodedPowerShell","LocalAccountCreation",
        "LocalAdminGroupChange","ScheduledTaskCreation","ServiceCreation",
        "LOLBins","ReconCommands","ArchiveActivity","All"
    )]
    [string]$Scenario
)

function Run-SuspiciousPowerShell {
    powershell -ExecutionPolicy Bypass -Command "Get-ChildItem Env:; Get-LocalUser; Get-Process | Select-Object -First 10"
}
function Run-EncodedPowerShell {
    $cmd = 'Get-Date; Get-Process | Select-Object -First 5'
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd)
    $encoded = [Convert]::ToBase64String($bytes)
    powershell.exe -EncodedCommand $encoded
}
function Run-LocalAccountCreation { net user labsvcuser P@ssw0rd123! /add }
function Run-LocalAdminGroupChange { net localgroup Administrators labsvcuser /add }
function Run-ScheduledTaskCreation { schtasks /create /tn "LabUpdateTask" /tr "cmd.exe /c whoami > C:\Temp\labtask.txt" /sc once /st 23:59 /f }
function Run-ServiceCreation { sc.exe create LabService binPath= "cmd.exe /c echo LabService > C:\Temp\labservice.txt" start= demand }
function Run-LOLBins { certutil -hashfile C:\Windows\System32\cmd.exe SHA256; whoami /priv; cmd.exe /c "dir C:\Windows\Temp" }
function Run-ReconCommands { whoami; whoami /groups; hostname; ipconfig /all; net user; net localgroup administrators; tasklist; systeminfo }
function Run-ArchiveActivity {
    New-Item -ItemType Directory -Path C:\Temp -Force | Out-Null
    Set-Content -Path C:\Temp\labfile1.txt -Value "test1"
    Set-Content -Path C:\Temp\labfile2.txt -Value "test2"
    Compress-Archive -Path C:\Temp\labfile1.txt,C:\Temp\labfile2.txt -DestinationPath C:\Temp\lab_archive.zip -Force
}
function Run-All {
    Run-SuspiciousPowerShell; Start-Sleep 2
    Run-EncodedPowerShell; Start-Sleep 2
    Run-LocalAccountCreation; Start-Sleep 2
    Run-LocalAdminGroupChange; Start-Sleep 2
    Run-ScheduledTaskCreation; Start-Sleep 2
    Run-ServiceCreation; Start-Sleep 2
    Run-LOLBins; Start-Sleep 2
    Run-ReconCommands; Start-Sleep 2
    Run-ArchiveActivity
}
switch ($Scenario) {
    "SuspiciousPowerShell" { Run-SuspiciousPowerShell }
    "EncodedPowerShell" { Run-EncodedPowerShell }
    "LocalAccountCreation" { Run-LocalAccountCreation }
    "LocalAdminGroupChange" { Run-LocalAdminGroupChange }
    "ScheduledTaskCreation" { Run-ScheduledTaskCreation }
    "ServiceCreation" { Run-ServiceCreation }
    "LOLBins" { Run-LOLBins }
    "ReconCommands" { Run-ReconCommands }
    "ArchiveActivity" { Run-ArchiveActivity }
    "All" { Run-All }
}
