#########################################################
#
# Name: pcinfo.ps1
# Author: Michael Tam
# Version: 1.1
# Date: 30/03/2023
# Comment: PowerShell script to collect computer configuration and inventory data
# 
# Requirement: Windows 7 or above.
#########################################################


# Getting hostname
#$env:computername

# Setting hostname
$input = Read-Host "Type your three letter computer code"
Rename-Computer -newname "HKT$input" -whatif
restart-computer -force -whatif



# Setting a Static IP Address – Windows 8 or Newer
$IP = "10.10.10.10"
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "10.10.10.1"
$Dns = "10.10.10.100"
$IPType = "IPv4"
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}
 # Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS



# Get Microsoft Office Version
function Get-OfficeVersion ($computer = $env:COMPUTERNAME) {
    $version = 0
 
    $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $computer)

    try {
        $reg.OpenSubKey('SOFTWARE\Microsoft\Office').GetSubKeyNames() | % {
            if ($_ -match '(\d+)\.') {
                if ([int]$matches[1] -gt $version) {
                    $version = $matches[1]
                }
            }
        }
    } catch {}
 
    $version
}
Get-OfficeVersion

<#
16.0 means that you have Microsoft Office 2016 or Microsoft Office 2019, or Microsoft Office 365
15.0 means that you have Microsoft Office 2013
14.0 means that you have Microsoft Office 2010
12.0 means that you have Microsoft Office 2007
11.0 means that you have Microsoft Office 2003
#>



# Getting volume label
Get-Volume
