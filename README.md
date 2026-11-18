# Azure Cloud-Native Migration Project

## Project Overview

This project demonstrates the deployment and monitoring of a cloud-hosted web application environment on Microsoft Azure using Infrastructure as Code (IaC).

The objective is to establish a foundation for migrating a traditional web workload to the cloud while developing practical experience with cloud infrastructure, networking, Linux administration, security, automation, and monitoring.

The project includes infrastructure provisioning, web server deployment, centralized logging, performance monitoring, availability testing, and automated alerting.

## Technologies Used

- Microsoft Azure
- Terraform
- Bicep
- Azure Monitor
- Log Analytics
- Application Insights
- Azure Monitor Agent (AMA)
- Data Collection Rules (DCR)
- Ubuntu Server 24.04 LTS
- Nginx
- PowerShell
- Azure CLI
- Git and GitHub
- HTML
- Azure Key Vault
- Azure RBAC
- Managed Identities

## Infrastructure Deployed

- Azure Resource Group
- Azure Virtual Network
- Dedicated web and application subnets
- Network Security Group
- Ubuntu Linux Virtual Machine
- Static Public IP address
- Nginx web server
- Custom HTML landing page
- System-assigned managed identity
- Azure Key Vault

## Project Architecture

The architecture documentation illustrates the Azure infrastructure, network components, security controls, monitoring services, and application traffic flow.

[View Azure Architecture](docs/architecture.md)

## Infrastructure as Code

Terraform was used to provision the foundational Azure infrastructure, including:

- Resource Group
- Virtual Network and subnets
- Network Security Group
- Linux Virtual Machine
- Public IP address
- Network interfaces

Bicep was used to deploy Azure monitoring resources.

This project demonstrates the use of multiple Infrastructure as Code technologies to manage cloud resources.

## Application Deployment

An Ubuntu Server 24.04 LTS virtual machine was deployed to Azure and configured to host a custom website using Nginx.

SSH key-based authentication was configured for administrative access, with inbound SSH traffic restricted through Network Security Group rules.

The website is accessible through the virtual machine's public IP address over HTTP.

## Security Implementation

Security controls implemented include:

- SSH key-based authentication.
- Restricted inbound SSH access using an IP address allowlist.
- Network Security Group configuration.
- Separation of web and application subnets.
- System-assigned managed identity.
- Sensitive configuration and credential files excluded from version control.
- Azure Key Vault for centralized secret management.
- System-assigned managed identity for VM authentication.
- Azure RBAC with least-privilege Key Vault access.
- Secret retrieval validation without embedded credentials.

## Monitoring and Logging

Azure Monitor and Log Analytics were configured to provide infrastructure monitoring and centralized logging.

Implementation includes:

- Log Analytics workspace.
- Azure Monitor Agent (AMA).
- Linux Data Collection Rule (DCR).
- Data Collection Rule association.
- Virtual machine heartbeat monitoring.
- Linux performance counter collection.
- Subscription Activity Log diagnostic settings.
- Application Insights availability monitoring.

Performance and system monitoring data is collected and queried through Log Analytics.

## Availability Monitoring and Alerting

Application Insights Standard availability testing was configured to monitor the Nginx website.

A scheduled query alert rule was created using KQL to detect failed availability checks.

The alert configuration includes:

- Five-minute evaluation frequency.
- Ten-minute evaluation window.
- Severity 2.
- Action Group integration for email notifications.
- Automatic alert mitigation.

### Failure Simulation and Recovery Test

A controlled outage was simulated by temporarily configuring an Nginx endpoint to return HTTP 503.

The monitoring workflow was validated:

1. Simulated an application availability failure.
2. Confirmed Azure recorded `Success = false`.
3. Verified the scheduled query alert entered the Fired state.
4. Removed the temporary failure endpoint.
5. Confirmed the homepage returned HTTP 200 OK.
6. Verified Azure recorded successful availability checks.
7. Confirmed the alert transitioned to Resolved.

This demonstrated the monitoring, detection, alerting, and recovery lifecycle.

## Repository Structure

- `terraform/` — Terraform infrastructure configuration.
- `monitoring/` — Azure monitoring configuration, Bicep templates, and scripts.
- `scripts/` — PowerShell automation scripts.
- `website/` — Custom HTML website files.
- `docs/` — Architecture and project documentation.
- `screenshots/` — Deployment, monitoring, and testing evidence.

## Skills Demonstrated

- Microsoft Azure administration.
- Infrastructure as Code using Terraform and Bicep.
- Azure networking and security.
- Linux server administration.
- Nginx web server configuration.
- Azure Monitor and Log Analytics.
- Application Insights availability monitoring.
- Kusto Query Language (KQL).
- Azure Monitor Agent and Data Collection Rules.
- Scheduled query alerts and Action Groups.
- PowerShell automation.
- Azure CLI.
- Troubleshooting and incident recovery.
- Git and GitHub documentation.
- Azure Key Vault administration.
- Managed Identity authentication.
- Azure role-based access control (RBAC).
- Secure cloud secret management.

## Future Improvements

- Configure HTTPS using TLS certificates.
- Introduce Docker containerization.
- Implement a CI/CD pipeline using GitHub Actions.
- Explore Azure-native application hosting services.
- Expand infrastructure deployment automation.

## Screenshot Gallery

Visual evidence of the infrastructure deployment, Linux configuration, Azure security controls, monitoring, and availability testing is available in the [Project Screenshot Gallery](docs/screenshots.md).
