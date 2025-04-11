Write-host Starting Windows Windows 11 Apps Build

#(New-Object System.Net.WebClient).DownloadFile("https://merlot.centrastage.net/csm/profile/downloadAgent/513d13b1-2a61-460f-8f2a-730c64acb7c4", "$env:TEMP/AgentInstall.exe");start-process "$env:TEMP/AgentInstall.exe"

powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-ac 0

# Open the .msixbundle file
Start-Process "D:\AppInstaller.Msixbundle"

# Add a delay to wait for the installer to open
Start-Sleep -Seconds 3

# Add .NET assembly to use key simulation
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class SendKeys {
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, uint dwExtraInfo);
    public static byte VK_RETURN = 0x0D;  // Return key
    public static uint KEYEVENTF_KEYUP = 0x02;
    public static uint KEYEVENTF_KEYDOWN = 0x00;
    public static void SendEnter() {
        keybd_event(VK_RETURN, 0, KEYEVENTF_KEYDOWN, 0);
        keybd_event(VK_RETURN, 0, KEYEVENTF_KEYUP, 0);
    }
}
"@

# Simulate pressing the Enter (OK) key
[SendKeys]::SendEnter()


Start-Sleep -Seconds 180

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

$dcuPath = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
Start-Process $dcuPath -ArgumentList "/scan" -Wait
Start-Process $dcuPath -ArgumentList "/applyUpdates -silent" -Wait

Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -IgnoreReboot

Start-Process SystemPropertiesComputerName
