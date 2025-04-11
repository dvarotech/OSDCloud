powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate


Add-AppxPackage -Path "D:\AppInstaller.Msixbundle" -ForceApplicationShutdow

(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"

usoclient StartScan
usoclient StartInstall

winget install -e --silent --accept-source-agreements --accept-package-agreements Dell.CommandUpdate
winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Teams
winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Edge
winget install -e --silent --accept-source-agreements --accept-package-agreements Google.Chrome
winget install -e --silent --accept-source-agreements --accept-package-agreements Mozilla.Firefox
winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Teams
winget install -e --silent --accept-source-agreements --accept-package-agreements Adobe.Acrobat.Reader.64-bit
winget install -e --silent --accept-source-agreements --accept-package-agreements 7zip.7zip
winget install -e --silent --accept-source-agreements --accept-package-agreements WatchGuard.MobileVPNWithSSLClient
winget install -e --silent --accept-source-agreements --accept-package-agreements VideoLAN.VLC
winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.OneDrive
winget install -e --silent --accept-source-agreements --accept-package-agreements Microsoft.Office

Set-ExecutionPolicy Default

Start-Process SystemPropertiesComputerName
