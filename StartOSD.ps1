@ECHO OFF
wpeinit
cd\
title OSD 25.1.26.3
PowerShell -Nol -C Initialize-OSDCloudStartnet
PowerShell -Nol -C Initialize-OSDCloudStartnetUpdate
@ECHO OFF
ECHO Start-OSDCloud
start /wait PowerShell -NoL -C Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-GB -OSActivation Retail -ZTI -Restart
@ECHO ON
