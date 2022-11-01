$cred=Get-Credential
Enter-PSSession -VMName Server3 -Credential $cred
Install-WindowsFeature dns -includemanagementtools