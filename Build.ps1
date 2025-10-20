# ===================================================================
# SCRIPT: System Setup and Update
# PURPOSE: Configures power settings, installs standard applications,
#          updates Dell drivers, and installs Windows updates.
# NOTES: Run this script with Administrator privileges.
# ===================================================================

$serial = (Get-WmiObject Win32_BIOS).SerialNumber.Trim()
$newName = "ARW-$serial"
Rename-Computer -NewName $newName -Force

# --- 1. Configure Power Settings ---
Write-Host "Configuring power settings..." -ForegroundColor Green
powercfg /change standby-timeout-ac 60
powercfg /change monitor-timeout-ac 60
powercfg /change hibernate-timeout-ac 60
Write-Host "Power settings have been set to 60 minutes for AC power."

# --- 2. Install RMM Agent ---
Write-Host "Installing the RMM Agent..." -ForegroundColor Green
(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"
Write-Host "RMM Agent installation complete."


# --- 3. Install Applications via Winget ---
Write-Host "Installing standard applications using Winget..." -ForegroundColor Green
# Create a list of application IDs to install
$wingetApps = @(
    "Dell.CommandUpdate",
    "Microsoft.Teams",
    "Microsoft.Edge",
    "Google.Chrome",
    "Mozilla.Firefox",
    "Adobe.Acrobat.Reader.64-bit",
    "7zip.7zip",
    "WatchGuard.MobileVPNWithSSLClient",
    "VideoLAN.VLC",
    "Microsoft.OneDrive",
    "Microsoft.Office"
)

# Loop through the list and install each application
foreach ($app in $wingetApps) {
    Write-Host "Installing $app..."
    # --silent makes it non-interactive
    # --accept-package-agreements and --accept-source-agreements handle licenses
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}

# --- 4. Run Dell Command Update ---
Write-Host "Checking for Dell driver and firmware updates..." -ForegroundColor Green
$dcuPath = "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe"

if (Test-Path $dcuPath) {
    # Scan for updates
    Start-Process -FilePath $dcuPath -ArgumentList "/scan" -Wait
    Write-Host "Scan complete. Applying updates..."
    
    # Apply updates and suppress the reboot prompt
    Start-Process -FilePath $dcuPath -ArgumentList "/applyUpdates -reboot=disable" -Wait
    Write-Host "Dell updates applied. A manual reboot may be required later."
}
else {
    Write-Host "Dell Command Update not found at $dcuPath. Skipping." -ForegroundColor Yellow
}

# --- 5. Install Windows Updates ---
Write-Host "Checking for and installing Windows Updates..." -ForegroundColor Green
# Install the PSWindowsUpdate module if it's not already there
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "PSWindowsUpdate module not found. Installing..."
    Install-Module -Name PSWindowsUpdate -Force -AcceptLicense -Confirm:$false
}

# Check for, download, and install all available updates.
# -AcceptAll accepts all prompts
# -AutoReboot will restart the computer automatically if required
Install-WindowsUpdate -AcceptAll

Write-Host "Script finished. The system will reboot if an update requires it." -ForegroundColor Cyan
