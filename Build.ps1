Write-host Starting Windows Windows 11 Apps Build

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install office365business --version 18526.20146 -y

(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"

powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

#winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements

#Get-AppxPackage *AppInstaller* | Remove-AppxPackage
#Add-AppxPackage -Path "D:\AppInstaller.Msixbundle" -ForceApplicationShutdow 
Add-AppxPackage -AppInstallerFile "D:\AppInstaller.Msixbundle"

#winget install -e --silent --accept-source-agreements --accept-package-agreements Dell.CommandUpdate
#winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Teams
#winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Edge
#winget install -e --silent --accept-source-agreements --accept-package-agreements Google.Chrome
#winget install -e --silent --accept-source-agreements --accept-package-agreements Mozilla.Firefox
#winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Teams
#winget install -e --silent --accept-source-agreements --accept-package-agreements Adobe.Acrobat.Reader.64-bit
#winget install -e --silent --accept-source-agreements --accept-package-agreements 7zip.7zip
#winget install -e --silent --accept-source-agreements --accept-package-agreements WatchGuard.MobileVPNWithSSLClient
#winget install -e --silent --accept-source-agreements --accept-package-agreements VideoLAN.VLC
#winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.OneDrive
#winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Office

$dcuPath = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
Start-Process $dcuPath -ArgumentList "/scan" -Wait
Start-Process $dcuPath -ArgumentList "/applyUpdates -silent" -Wait

Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate
 Install-WindowsUpdate -AcceptAll -IgnoreReboot

Start-Process SystemPropertiesComputerName
