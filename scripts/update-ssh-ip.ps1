
$dir = "$HOME\Documents\Azure-Cloud-Native-Migration\terraform"

# Get your current public IP
$myIP = (Invoke-RestMethod "https://api.ipify.org").Trim()

Write-Host "Your current public IP is: $myIP"

# Update the local Terraform variables file
$file = Join-Path $dir "terraform.tfvars"

$content = "ssh_allowed_ip = `"$myIP/32`""

Set-Content -Path $file -Value $content

Write-Host "Terraform SSH IP variable updated successfully."
