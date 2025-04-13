Write-host Starting Windows Windows 11 Apps Build v3

#Set power plan to always on
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

#installs datto
(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"

#installs chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install dellcommandupdate --version 5.4.0.20241021 -y
choco install microsoft-teams-new-bootstrapper --version 1.0.2414501 -y
choco install microsoft-edge --version 135.0.3179.73 -y
choco install googlechrome --version 135.0.7049.85 -y
choco install firefox --version 137.0.1 -y
choco install adobereader --version 2025.1.20432 -y
choco install 7zip --version 24.9.0 -y
choco install vlc --version 3.0.21 -y
choco install onedrive --version 25.46.310.5 -y
choco install office365business --version 18526.20146 -y

choco upgrade -y

$dcuPath = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
Start-Process $dcuPath -ArgumentList "/scan" -Wait
Start-Process $dcuPath -ArgumentList "/applyUpdates -silent" -Wait

Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -IgnoreReboot

Start-Process SystemPropertiesComputerName
