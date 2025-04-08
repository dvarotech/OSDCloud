Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module -Name WriteAscii
Powershell is fun!’ | Write-Ascii -ForegroundColor Rainbow -Compress

Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-gb -OSActivation Retail -Firmware -ZTI -Restart
