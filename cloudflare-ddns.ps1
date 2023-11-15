# Define the parameters for the API request
$zone_id = "your_zone_id" # The ID of the zone where the record belongs
$record_id = "your_record_id" # The ID of the record to update
$record_type = "A" # The type of the record, e.g. A, CNAME, MX, etc.
$record_name = "example.com" # The name of the record, e.g. example.com, www.example.com, etc.
$record_content = "1.2.3.4" # The content of the record, e.g. an IP address, a domain name, etc.
$record_ttl = 1 # The time to live of the record, in seconds
$record_proxied = $true # Whether to enable Cloudflare proxy for the record


# Create a JSON object with the record data
$record_data = @{
    type = $record_type
    name = $record_name
    content = $record_content
    ttl = $record_ttl
    proxied = $record_proxied
} | ConvertTo-Json

# Set the headers for the API request
$headers = @{
    "Authorization" = "Bearer $auth_key" # The email address associated with your Cloudflare account
    "Content-Type" = "application/json"
}

# Invoke the API request verify token
Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/user/tokens/verify" -Method 'GET' -Headers $headers

# Invoke the API request list DNS records
(Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records" -Method 'GET' -Headers $headers).result | ft

# Invoke the API request update DNS records
Invoke-RestMethod -URI "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$record_id" -Method 'PUT' -Headers $headers -Body $record_data

# Invoke the API request create DNS records
Invoke-RestMethod -URI "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records" -Method 'POST' -Headers $headers -Body $record_data

# Cloudflare API in the Cloudflare API Documentation
# https://developers.cloudflare.com/api/operations/dns-records-for-a-zone-create-dns-record

