Azure Infrastructure Security
Overview
Security controls were configured as part of this Azure Cloud-Native
Migration project to restrict administrative access and control inbound
network traffic to the Ubuntu virtual machine.
Network Security Group
An Azure Network Security Group (NSG) named nsg-cloud-migration was
configured and associated with the application subnet hosting the
virtual machine.

The NSG controls inbound network traffic using security rules.
Inbound Rules
  Rule                           Port Protocol      Access        Purpose
  Allow-SSH-My-IP                  22 TCP           Allow         Permits SSH
administration
from the
authorized
public IP
address
Allow-HTTP                       80 TCP           Allow         Permits web
traffic to reach
the Nginx
website
SSH access is restricted to an authorized IP address rather than being
open to all internet addresses. The authorized IP address may need to be
updated when the administrator changes networks.

HTTP access is available publicly so visitors can reach the hosted
website.
SSH Authentication
The Ubuntu virtual machine uses SSH key-based authentication.

Password-based SSH authentication is disabled in the virtual machine
configuration. The public key is configured on the VM, while the
corresponding private key remains on the administrator's computer.

Private SSH keys must never be uploaded to GitHub or shared.
Network Segmentation
The Azure Virtual Network uses separate subnets:
- Web subnet: 10.0.1.0/24
- Application subnet: 10.0.2.0/24
The Ubuntu virtual machine's network interface is connected to the
application subnet. The web subnet is reserved for potential future
web-tier resources and is not currently hosting a separate resource.
Source Control and Sensitive Data
The project uses a .gitignore file to exclude sensitive or local
files, including Terraform state files, local Terraform working
directories, variable files, environment files, and SSH key filenames
covered by the ignore rules.

Terraform state files can contain sensitive infrastructure information.
They should be stored securely and must not be committed to a public
repository.
Current Security Limitations and Future Improvements
The website currently uses HTTP on port 80. HTTP traffic is not
encrypted.

Potential improvements include:
- Configure HTTPS using a TLS certificate.
- Restrict or remove public SSH access by using Azure Bastion, a VPN,
  or another controlled administration path.
- Review and minimize inbound network rules.
- Store Terraform state in a secured remote backend with appropriate
  access controls.
- Enable Azure monitoring and security logging.
Summary
This project demonstrates foundational Azure security practices,
including network traffic filtering with an NSG, restricted SSH access,
SSH key-based authentication, network segmentation, and exclusion of
sensitive files from source control.

## Azure Key Vault and Managed Identity

Azure Key Vault was deployed using Terraform to provide centralized secret management.

### Key Vault Security Configuration

- Azure RBAC authorization enabled.
- Purge protection enabled.
- Seven-day soft-delete retention configured.
- Public network access remains enabled for this lab environment.

### Role-Based Access Control

Two role assignments were configured at Key Vault scope:

| Identity | Azure role | Purpose |
|---|---|---|
| Ubuntu VM system-assigned managed identity | Key Vault Secrets User | Read secret values |
| Administrator identity | Key Vault Secrets Officer | Manage secrets |

The Ubuntu VM authenticates to Azure through its system-assigned managed identity, avoiding stored credentials inside the virtual machine.

### Validation

The integration was tested from the Ubuntu VM:

- Managed identity successfully obtained a Key Vault access token.
- Key Vault returned HTTP 200.
- Secret retrieval succeeded.
- Secret values were not printed in the validation output.

### Production considerations

For production, evaluate private endpoints and network restrictions, diagnostic logging, secret rotation, and secure remote Terraform state storage.
