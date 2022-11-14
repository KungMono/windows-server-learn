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
