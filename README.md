# Azure Cloud-Native Migration Project

A hands-on Azure infrastructure and operations portfolio project demonstrating Infrastructure as Code, Linux workload hosting, cloud identity and access management, secrets management, monitoring, alerting, and incident troubleshooting.

> **Environment:** Personal Azure lab / portfolio project. This is not a production deployment.

## Project Overview

Designed and deployed an Azure-hosted Linux web workload using Terraform, then expanded the environment with managed identity, Azure Key Vault, centralized monitoring, and application availability checks. The project emphasizes repeatable infrastructure, least-privilege access, operational visibility, and documented troubleshooting.

## Architecture and Technologies

- **Cloud:** Microsoft Azure
- **Infrastructure as Code:** Terraform and Bicep
- **Compute:** Ubuntu Server 24.04 LTS virtual machine
- **Web service:** Nginx
- **Networking:** Azure Virtual Network, web/application subnets, Network Security Group, static public IP
- **Identity and secrets:** System-assigned managed identity, Azure RBAC, Azure Key Vault
- **Monitoring:** Azure Monitor Agent, Data Collection Rules, Log Analytics, Application Insights
- **Alerting:** KQL scheduled query alert and Azure Monitor Action Group email notification
- **Automation and tooling:** Azure CLI, PowerShell, Git, GitHub

## Implemented Capabilities

### Infrastructure as Code
- Provisioned an Azure resource group, virtual network, segmented subnets, NSG, public IP, network interface, and Ubuntu VM with Terraform.
- Used input variables for environment-specific SSH source IP configuration.
- Used Bicep to define an Application Insights standard availability test.

### Workload Identity and Secrets Management
- Enabled a system-assigned managed identity on the Linux VM.
- Applied Azure RBAC roles at Key Vault scope: **Key Vault Secrets User** for the VM identity and **Key Vault Secrets Officer** for the administrator identity.
- Enabled Key Vault RBAC authorization, purge protection, and soft delete.
- Validated managed-identity authentication and secret retrieval from the VM without placing secret values in the validation output.

### Monitoring and Availability
- Configured Azure Monitor Agent and a Data Collection Rule to collect Linux performance counters and selected Syslog events at a 60-second sampling interval.
- Routed collected data to Log Analytics.
- Configured an Application Insights availability test to send HTTP GET requests to the Nginx site every five minutes and expect HTTP 200 responses.
- Created a KQL scheduled query alert and Action Group email notification.
- Validated monitoring behavior through a controlled website outage and subsequent recovery.

### Troubleshooting and Operations
- Diagnosed SSH timeouts caused by a changing ISP public IP and an NSG rule that still allowed the previous address.
- Used PowerShell to identify the current public IP and update the local Terraform variable file, then applied the targeted NSG change.
- Documented the incident, root cause, resolution, and lessons learned.

## Repository Structure

- `terraform/` — Azure infrastructure definitions.
- `monitoring/` — Data Collection Rule, Bicep availability test, and PowerShell IP-monitoring script.
- `docs/` — Architecture, deployment, security, troubleshooting, and incident documentation.
- `screenshots/` — Selected deployment and validation evidence.
- `website/` — Nginx website content.
- `scripts/` — SSH source-IP update helper.

## Documentation

- [Architecture](docs/architecture.md)
- [Deployment](docs/deployment.md)
- [Security](docs/security.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Incident report: SSH access after a dynamic public IP change](docs/incidents/INC-002-dynamic-public-ip-ssh-access.md)

## Monitoring Source Files

- [Application Insights availability test (Bicep)](monitoring/bicep/availability-test.bicep)
- [Linux Data Collection Rule example (sanitized)](monitoring/linux-dcr.example.json)
- [Public IP change notification script (PowerShell)](monitoring/scripts/monitor-public-ip.ps1)

## Security Notes and Lab Limitations

- SSH is configured for public-key authentication; password-based SSH authentication is disabled.
- Inbound SSH is restricted to a configurable authorized source IP (/32); HTTP port 80 is open for the demonstration website.
- Terraform state, local `.tfvars`, private keys, credentials, and local public-IP monitoring state must remain out of version control.
- Key Vault public network access is enabled for this lab. A production design should evaluate private endpoints, network restrictions, diagnostic settings, secret rotation, and secure remote Terraform state.
- The demo website currently uses HTTP. Production hosting should use HTTPS/TLS and an appropriately hardened network design.
- The web subnet is provisioned as a separate network segment; the current Ubuntu workload is deployed in the application subnet.

## Skills Demonstrated

Azure infrastructure provisioning, Terraform, Bicep, Azure networking, Linux administration, Nginx, managed identities, Azure RBAC, Key Vault, Azure Monitor, Log Analytics, Application Insights, KQL, PowerShell automation, troubleshooting, and technical documentation.
