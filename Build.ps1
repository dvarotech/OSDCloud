Write-host Starting Windows Windows 11 Apps Build v6

#Set power plan to always on
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0




#installs datto
(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"

#installs chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install microsoft-office-deployment /64 -y
choco install dellcommandupdate -y
choco install office365proplus -y
choco install microsoft-teams-new-bootstrapper -y
choco install microsoft-edge -y
choco install googlechrome -y
choco install firefox -y
choco install adobereader -y
choco install 7zip -y
choco install vlc -y
choco install onedrive -y

choco upgrade all -y

Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -IgnoreReboot

$dcuPath = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
Start-Process $dcuPath -ArgumentList "/scan" -Wait
Start-Process $dcuPath -ArgumentList "/applyUpdates -silent" -Wait




Start-Process SystemPropertiesComputerName
