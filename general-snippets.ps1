#list of general powershell commands / snippets


#list installed software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

#buildnumber
Get-CIMInstance -ComputerName localhost -Class win32_operatingsystem | Select-Object -Expandproperty BuildNumber
#serialnumber
Get-WmiObject win32_SystemEnclosure | select serialnumber
#bios version
Gwmi Win32_bios
#macaddress
Get-WmiObject win32_networkadapterconfiguration | select description, macaddress
#General info
Get-WmiObject -Query "select * from win32_computersystem"
#uptime
Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime
#list users
Get-WMIObject -class Win32_ComputerSystem | select username
#list last loggedin
Get-Process -IncludeUserName | Select-Object -Property username -Unique | Where-Object { $_ -notmatch 'SYSTEM|admin' }
