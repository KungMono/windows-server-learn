$cred=Get-Credential
Enter-PSSession -VMName Server3 -Credential $cred
Install-WindowsFeature dns -includemanagementtools
Add-DnsServerPrimaryZone -Name "fujistore.com.hk" -ZoneFile "fujistore.com.hk.dns"
Install-WindowsFeature Web-Server -IncludeManagementTools