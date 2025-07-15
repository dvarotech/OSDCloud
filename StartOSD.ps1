Write-Host "Starting ARO Internal IT Windows 11 24h2 - 15-07-2025." -ForegroundColor Green
Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-gb -OSActivation Retail -Firmware -ZTI -Restart
