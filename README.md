# Azure Cloud-Native Migration Project

## Project Overview

This project demonstrates the deployment of a cloud-hosted web application environment on Microsoft Azure using Infrastructure as Code (IaC).

The objective is to establish a foundation for migrating a traditional web workload to the cloud while developing practical experience with cloud infrastructure, networking, Linux administration, and deployment automation.

## Technologies Used

- Microsoft Azure
- Terraform
- Ubuntu Server 24.04 LTS
- Nginx
- PowerShell
- Git and GitHub
- HTML

## Infrastructure Deployed

- Azure Resource Group
- Azure Virtual Network
- Dedicated web and application subnets
- Network Security Group
- Ubuntu Linux Virtual Machine
- Static Public IP address
- Nginx web server
- Custom HTML landing page

## Project Architecture

The architecture documentation illustrates the Azure infrastructure, network components, security controls, and application traffic flow.

[View Azure Architecture](docs/architecture.md)

## Implementation

Infrastructure was provisioned using Terraform and deployed to Microsoft Azure.

The Ubuntu virtual machine was configured to host a custom website using Nginx. SSH key-based authentication was used for administrative access, with inbound SSH traffic restricted through network security rules.

## Security Considerations

- SSH key-based authentication.
- Restricted inbound SSH access.
- Network Security Group configuration.
- Separation of web and application subnets.
- Sensitive configuration and credential files excluded from version control.

## Project Evidence

Deployment screenshots are available in the `screenshots/` directory.

The `terraform/` directory contains the infrastructure configuration, and the `website/` directory contains the custom HTML landing page.

## Skills Demonstrated

- Infrastructure as Code (Terraform)
- Microsoft Azure administration
- Cloud networking and security
- Linux server administration
- Web server configuration
- PowerShell
- Git version control
- Technical documentation

## Planned Improvements

- Configure HTTPS.
- Implement Azure monitoring and logging.
- Introduce Docker containerization.
- Build a CI/CD pipeline using GitHub Actions.
- Explore Azure-native application hosting services.