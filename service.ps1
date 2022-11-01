$botid = "bot5566067059:AAF3zqCICaMufmpcokSomkz2U38BeKW6OTk"
$chatid = "5411423187"

$a=gsv | where {$_.Name -eq "XboxNetApiSvc" -and $_.Status -eq "Running"}
if($a) {
    Write-Host "Xbox service is running"
    Stop-Service XboxNetApiSvc
    iwr "https://api.telegram.org/$botid/sendMessage?chat_id=$chatid&text=xbox%20is%20killed%20on%"
}

