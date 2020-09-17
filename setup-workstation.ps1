
#keyboard
Get-WinUserlanguageList
Set-WinUserLanguageList -LanguageList NB
#Set-WinUserLanguageList no-nb -Force

#screen
Set-DisplayResolution -Width 1920 -Height 1200
#Set-ScreenResolution -Width 1920 -Height 1080 -DeviceID 0

#timezone
get-timezone -listall
Set-TimeZone -Id 'W. Europe Standard Time'


#screensaver
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveActive -Value 1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveTimeOut -Value 60
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name scrnsave.exe -Value "c:\windows\system32\mystify.scr"

#

#ip settings
$IP = "10.0.2.200"
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "10.0.2.1"
$IPType = "IPv4"

#find first adapter that is up
$upadapter = Get-NetAdapter | ? { $_.Status -eq "Up" } | Select-Object -First 1 | Select-Object -ExpandProperty ifIndex
#reset settings
Remove-NetIPAddress -InterfaceIndex $upadapter -AddressFamily $IPType -Confirm:$false

#adapter settings
Get-NetAdapter -InterfaceIndex $upadapter | `
New-NetIPAddress -AddressFamily $IPType `
				 -IPAddress $ip `
				 -PrefixLength $MaskBits `
				 -DefaultGateway $Gateway

#dns
Set-DnsClientServerAddress -InterfaceIndex $upIndex -ServerAddresses ("10.0.0.2", "10.0.0.3")

#network, disable ipv6
Get-NetAdapterBinding -ComponentID 'ms_tcpip6' | disable-NetAdapterBinding -ComponentID ms_tcpip6 -PassThru

#disable inactive adapters
Get-NetAdapter | ? { $_.status -eq "Disconnected" } | Disable-NetAdapter -Confirm:$false

###

#WSL
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile WSLUpdate.msi -UseBasicParsing
msiexec.exe /package WSLUpdate.msi /quiet
wsl --set-default-version 2
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx

#Fontes:
#https://docs.microsoft.com/pt-br/windows/wsl/install-win10
#https://docs.microsoft.com/en-us/windows/wsl/install-manual

#CHOCOLATEY
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install microsoft-windows-terminal microsoft-teams vscode atom git terraform awscli lxc multipass nano nmap wget curl
#Fontes:
#https://chocolatey.org/install

POWERSHELL
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.0.1/PowerShell-7.0.1-win-x64.msi -OutFile PowerShell.msi -UseBasicParsing
msiexec.exe /package PowerShell.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
#OU
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.0.1/PowerShell-7.0.1-win-x64.msix -OutFile PowerShell.msix -UseBasicParsing
Add-AppxPackage PowerShell.msix
#POWERSHELL CORE
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v6.2.5/PowerShell-6.2.5-win-x64.msi -OutFile PowerShellCore.msi -UseBasicParsing
msiexec.exe /package PowerShellCore.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
#OU
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v6.2.5/PowerShell-6.2.5-win-x64.msix -OutFile PowerShellCore.msix -UseBasicParsing
Add-AppxPackage PowerShellCore.msix
#Fontes:
#https://docs.microsoft.com/pt-br/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7
#https://github.com/PowerShell/PowerShell/releases
#https://devblogs.microsoft.com/powershell/powershell-core-6-0-generally-available-ga-and-supported/

#WINGET
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile Winget.appx -UseBasicParsing
Add-AppxPackage .\Winget.appx
#Fontes:
https://github.com/microsoft/winget-cli/blob/master/README.md
https://github.com/microsoft/winget-cli/releases/tag/v0.1.4331-preview

#MICROSOFT EDGE
Invoke-WebRequest -Uri http://dl.delivery.mp.microsoft.com/filestreamingservice/files/1fc0c5fe-c1f5-4879-a43c-515d9f731444/MicrosoftEdgeEnterpriseX64.msi  -OutFile MicrosoftEdge.msi -UseBasicParsing
msiexec.exe /package MicrosoftEdge.msi /quiet

#MOZILLA FIREFOX
Invoke-WebRequest -Uri https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US -OutFile MozillaFirefox.msi -UseBasicParsing

#spotify
Invoke-WebRequest -Uri http://download.spotify.com/SpotifyFullSetup.exe -OutFile spotify.exe -UseBasicParsing

#wscode
winget install vscode



