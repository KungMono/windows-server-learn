Get-DnsServerResourceRecord -ZoneName "hk.fpca" -ComputerName "10.166.38.4" -RRType a | sort timestamp | out-gridview -PassThru

$a = Get-DnsServerResourceRecord -ZoneName "hk.fpca" -ComputerName "10.166.38.4" -RRType a | sort timestamp | out-gridview -PassThru

$a | Remove-DnsServerResourceRecord -ComputerName 10.166.38.4 -ZoneName "hk.fpca" -whatif

$a | Export-csv "dns.csv" -NoTypeInformation
ii .\dns.csv

$a | out-file dns.txt
ii .\dns.txt

Get-DnsServerResourceRecord -computername 10.166.38.4 -ZoneName hk.fpca -rrtype a | select hostname, recordtype, timestamp -first 30 -expand recorddata |ft
Get-DnsServerResourceRecord -computername 10.166.38.4 -ZoneName hk.fpca -rrtype a | select hostname, recordtype, timestamp -first 30 -expand recorddata | export-csv "dns.csv" -NoTypeInformation
ii dns.csv
gc .\dns.csv | select -First 3

$ComputerName = "10.166.38.4"
$ZoneName = "hk.contoso.com"
$RRType = "A"
$Servers = Import-Csv -Path dns2.csv
foreach ($Server in $Servers) {
    Write-Host "Removing DNS record for $($Server.Hostname)" -ForegroundColor red -BackgroundColor white
    Remove-DnsServerResourceRecord -ComputerName $ComputerName -ZoneName $ZoneName -RRType $RRType -Name $Server.HostName -Whatif
    Start-Sleep -Seconds 0.5
}
