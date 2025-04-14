Write-host Starting Windows Windows 11 Apps Build v8

#Set power plan to always on
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

$sp="C:\Program Files\WindowsPowerShell\Scripts";if(-not(Test-Path $sp)){New-Item -ItemType Directory -Path $sp};$p=[Environment]::GetEnvironmentVariable("PATH","Machine");if(-not $p.Contains($sp)){[Environment]::SetEnvironmentVariable("PATH","$p;$sp","Machine")};Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force;Install-PackageProvider -Name NuGet -Force -Scope CurrentUser;Install-Script -Name Get-WindowsAutopilotInfo -Force

Get-WindowsAutopilotInfo -OutputFile c:\Users\localadmin\Desktop\AutopilotHWID.csv

Write-host Installing Datto Agent
#installs datto
(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"

Write-host Installing chocolatey and apps
#installs chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#installs apps
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


Write-host Download and installl Windows updates
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -IgnoreReboot

Write-host Check for Dell updates
$dcuPath = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
Start-Process $dcuPath -ArgumentList "/scan" -Wait
Start-Process $dcuPath -ArgumentList "/applyUpdates -silent" -Wait


 

Start-Process SystemPropertiesComputerName
