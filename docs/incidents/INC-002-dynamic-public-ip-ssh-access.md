# INC-002: Dynamic Public IP Changes Causing SSH Connection Failures

**Project:** Azure Cloud-Native Migration  
**Environment:** Microsoft Azure / Ubuntu Linux VM  
**Affected VM:** `vm-ubuntu-migration`  
**Service:** SSH (TCP 22)  
**Severity:** Low — remote administrative access interrupted

## Summary

SSH connections to the Azure Ubuntu VM timed out after the public IP address assigned to the administrator's internet connection changed. The Network Security Group continued to allow the previous source address, so the new connection source did not match the permitted SSH rule.

## Root Cause

The inbound SSH rule uses a single authorized public IP address with a `/32` prefix. When the ISP-assigned public IP changed, the NSG rule no longer matched the administrator's current address.

## Resolution

1. Retrieved the current public IP from the Windows workstation using PowerShell:

   ```powershell
   (Invoke-RestMethod -Uri "https://api.ipify.org").Trim()
   ```

2. Ran the local helper script to update `terraform.tfvars` with the current `ssh_allowed_ip` value:

   ```powershell
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File "..\scripts\update-ssh-ip.ps1"
   ```

3. Reviewed the Terraform plan and confirmed the intended change was limited to the SSH network security rule.
4. Applied the Terraform change to update the NSG source address.
5. Reconnected to the Ubuntu VM over SSH and confirmed administrative access was restored.

## Result

- SSH access was restored.
- The VM and its managed identity remained in place.
- SSH remained restricted to one authorized public IP address rather than being opened to the internet.

## Lessons Learned

- ISP-assigned public IP addresses can change and invalidate source-IP firewall rules.
- Terraform variables keep environment-specific network values out of reusable configuration.
- A reviewed Terraform plan helps confirm the scope of a network security change before applying it.
- Azure Bastion or a VPN can reduce dependence on a changing public source IP for administration.

## Security Note

The actual public IP address and local Terraform variable file are intentionally not included in this incident report or repository.
