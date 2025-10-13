Write-Host "Starting ARO Internal IT Windows 11 24h2 - 13-10-2025." -ForegroundColor Green
Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 25H2 -OSEdition Pro -OSLanguage en-gb -OSActivation Retail -Firmware -ZTI -Restart
