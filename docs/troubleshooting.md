# Project Troubleshooting and Lessons Learned

## Azure Cloud-Native Migration Project

This document records technical issues encountered during the deployment and configuration of the Azure cloud environment, along with the troubleshooting steps used to resolve them.

### 1. Terraform Code Entered Directly into PowerShell

**Problem:** Terraform resource blocks were entered directly into Windows PowerShell. PowerShell interpreted Terraform syntax as commands and returned errors such as:

`The term 'resource' is not recognized as the name of a cmdlet.`

**Cause:** Terraform configuration is written in `.tf` files, not executed as individual PowerShell commands.

**Resolution:** Created and edited Terraform configuration files using Visual Studio Code. Used Terraform CLI commands to initialize, validate, plan, and apply the configuration.

**Lesson learned:** Understand the difference between infrastructure configuration files and terminal commands.

### 2. Terraform Infrastructure Drift

**Problem:** Terraform detected a difference between the SSH source IP configured in the Terraform file and the IP currently configured in Azure.

**Cause:** The public IP address had changed, leaving the local Terraform configuration out of sync with the Azure Network Security Group.

**Resolution:** Updated the Terraform SSH rule to match the authorized current public IP and ran `terraform plan`.

**Verification:** Terraform reported that there were no changes and the infrastructure matched the configuration.

**Lesson learned:** Terraform plans help detect configuration drift before changes are applied.

### 3. Existing Azure HTTP Rule Was Not Managed by Terraform

**Problem:** The HTTP inbound security rule had originally been created using Azure CLI rather than Terraform.

**Cause:** The resource existed in Azure but was not initially tracked in Terraform state.

**Resolution:** Added the HTTP security rule to the Terraform configuration and imported the existing Azure resource into Terraform state.

**Verification:** Terraform subsequently recognized the HTTP rule as a managed resource.

**Lesson learned:** Existing cloud resources can be imported into Terraform rather than unnecessarily recreated.

### 4. PowerShell Script Execution Policy

**Problem:** Windows PowerShell blocked execution of the SSH IP update script.

**Cause:** The system's PowerShell execution policy restricted running the script.

**Resolution:** Used a temporary process-level execution policy bypass to run the script without permanently changing the machine's execution policy.

**Lesson learned:** Understand PowerShell execution policies and use the least disruptive approach when running trusted scripts.

### 5. GitHub HTTPS Push Restriction

**Problem:** Git operations using HTTPS were blocked by Windows Application Control.

**Cause:** The local security controls prevented the attempted Git authentication method.

**Resolution:** Configured SSH authentication with a dedicated GitHub SSH key and successfully pushed the project to GitHub.

**Lesson learned:** SSH authentication provides an alternative Git authentication method when HTTPS is unavailable.

### 6. Terraform Variable Entered into PowerShell

**Problem:** A Terraform variable declaration was pasted into PowerShell and produced a `Get-Variable` error.

**Cause:** Terraform variable declarations belong in `.tf` configuration files, not in the PowerShell terminal.

**Resolution:** Created `variables.tf` in the Terraform directory using Visual Studio Code.

**Lesson learned:** Keep Terraform configuration, PowerShell commands, and Linux shell commands in their correct environments.

### 7. Security and Configuration Improvements

**Ongoing improvement:** The SSH public IP was previously hardcoded in the Terraform security configuration.

**Planned resolution:** Replace the hardcoded IP with a Terraform input variable and store its actual value in a local `terraform.tfvars` file excluded from GitHub.

The PowerShell update script will also be updated to modify the local variable file rather than the published Terraform configuration.

**Security objective:** Avoid publishing personal network information while preserving restricted SSH access.

---

## Overall Lessons Learned

- Use Infrastructure as Code to manage cloud resources consistently.
- Use Terraform plan to review changes before applying them.
- Import existing Azure resources when appropriate.
- Restrict administrative access using least privilege.
- Keep credentials, private keys, and Terraform state out of public repositories.
- Separate Windows PowerShell, Terraform, and Linux commands.
- Troubleshoot errors by understanding their cause rather than blindly repeating commands.

### 8. Dynamic Public IP Address Changes

**Problem:** The public IP address used to access the Azure Linux VM through SSH changed, causing the existing Network Security Group rule to become outdated.

**Cause:** The internet service provider or network connection assigned a different public IP address.

**Resolution:**
1. Created a PowerShell script to detect the current public IP address.
2. Updated the local `terraform.tfvars` file automatically.
3. Used a Terraform variable (`ssh_allowed_ip`) instead of hardcoding the IP address in the published configuration.
4. Ran `terraform fmt` and `terraform validate`.
5. Reviewed the Terraform plan and confirmed only the SSH security rule would change.
6. Applied the change to Azure.

**Verification:** Terraform successfully updated one resource in place. A subsequent `terraform plan` reported:

`No changes. Your infrastructure matches the configuration.`

**Security benefit:** SSH access remains restricted to one authorized public IP address rather than being exposed to the entire internet.

**Lesson learned:** Automating configuration updates with PowerShell and Terraform makes cloud infrastructure easier to maintain when network conditions change.