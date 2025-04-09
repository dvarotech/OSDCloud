(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"


winget install Dell.CommandUpdate
winget install Microsoft.Teams
winget install Microsoft.Edge
winget install Google.Chrome
winget install Mozilla.Firefox
winget install Microsoft.Teams
winget install Adobe.Acrobat.Reader.64-bit
winget install 7zip.7zip
winget install WatchGuard.MobileVPNWithSSLClient
winget install VideoLAN.VLC
winget install Microsoft.OneDrive
winget install Microsoft.Office

Rename-Computer -NewName (Read-Host "Enter the new computer name") -Force
Add-Computer -DomainName arrow.local -Server arrow\core-dc-02 -PassThru -Verbose
