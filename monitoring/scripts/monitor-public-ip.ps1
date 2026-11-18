# Public IP Change Monitoring
# Detects public IP changes and sends a Windows notification.

$StateFile = Join-Path $PSScriptRoot "last-known-ip.txt"

function Send-WindowsNotification {
    param (
        [string]$Title,
        [string]$Message
    )

    try {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $NotifyIcon = New-Object System.Windows.Forms.NotifyIcon
        $NotifyIcon.Icon = [System.Drawing.SystemIcons]::Information
        $NotifyIcon.Visible = $true
        $NotifyIcon.BalloonTipTitle = $Title
        $NotifyIcon.BalloonTipText = $Message
        $NotifyIcon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
        $NotifyIcon.ShowBalloonTip(10000)

        Start-Sleep -Seconds 3
        $NotifyIcon.Dispose()
    }
    catch {
        Write-Warning "Windows notification could not be displayed: $_"
    }
}

try {
    $CurrentIP = (Invoke-RestMethod -Uri "https://api.ipify.org" -TimeoutSec 10).Trim()
}
catch {
    Write-Error "Unable to retrieve the current public IP."
    exit 1
}

if (-not (Test-Path $StateFile)) {
    $CurrentIP | Set-Content -Path $StateFile
    Write-Host "Baseline established. Public IP monitoring started."
    exit 0
}

$PreviousIP = (Get-Content -Path $StateFile -Raw).Trim()

if ($CurrentIP -ne $PreviousIP) {
    Write-Host "PUBLIC IP CHANGE DETECTED"
    Send-WindowsNotification -Title "Public IP Changed" -Message "Your public IP address has changed. Check your SSH access configuration."
    $CurrentIP | Set-Content -Path $StateFile
    Write-Host "Monitoring state updated."
}
else {
    Write-Host "No public IP change detected."
}
