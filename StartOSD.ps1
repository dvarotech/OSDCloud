Write-Host "Starting ARO Internal IT Windows 11 25h2 - 13-10-2025." -ForegroundColor Green
Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 25H2 -OSEdition Pro -OSLanguage en-gb -OSActivation Retail -Firmware -ZTI
Write-Host "Downloading Post Install Script - 20-10-2025." -ForegroundColor Green
Invoke-WebRequest -Uri "http://159.65.21.143/Build/Build.ps1" -OutFile "C:\Build.ps1"
Invoke-WebRequest -Uri "http://159.65.21.143/Build/Build.ps1" -OutFile "D:\Build.ps1"

Invoke-WebRequest -Uri "http://159.65.21.143/Build/Join.ps1" -OutFile "C:\Join.ps1"
Invoke-WebRequest -Uri "http://159.65.21.143/Build/Join.ps1" -OutFile "D:\Join.ps1"

Write-Host "Rebooting." -ForegroundColor Green
Start-Sleep 5
Restart-Computer
