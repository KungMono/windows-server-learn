# CloudFlare Token
$token = "<<CLOUDFLARE API TOKEN>>"
$zone_identifier = "<<CLOUDFLARE ZONE IDENTIFIER>>"
$identifier = "<<CLOUDFLARE IDENTIFIER>>"
$name = "<<DNS HOSTNAME>>" 

# Telegram Token
$bot = "<<TELEGRAM BOT STRING, bot12345:ABCDEFG>>"
$receiver = "<<TELEGRAM RECEIVER ID>>"

$myip = irm ifconfig.io/ip
$cleanip = $myip -replace "`n","" -replace "`r",""

$headers=@{}
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", "Bearer $token")

$postParams = @{
    content="$cleanip"
    name="$name"
    type='A'
    comment='DDNS Record by PowerShell'
    ttl='3600'
}

Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$identifier" -Method PUT -Headers $headers -ContentType 'application/json' -Body ($postParams|ConvertTo-Json)
Invoke-RestMethod -Uri "https://api.telegram.org/$bot/sendMessage?chat_id=$receiver&text=Cloudflare has updated the ip address to $myip"
