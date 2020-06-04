
#keyboard
Get-WinUserlanguageList
Set-WinUserLanguageList -LanguageList NB

#screen
Set-DisplayResolution -Width 1920 -Height 1200

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
