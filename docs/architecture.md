
# Azure Cloud Migration — Architecture

## Architecture Overview

This diagram illustrates the Azure infrastructure deployed using Terraform and the flow of HTTP traffic to the hosted website.

```mermaid
flowchart TD
    A["User / Web Browser"] -->|"HTTP - Port 80"| B["Azure Static Public IP"]
    B --> C["Network Security Group"]
    C -->|"Allow HTTP - Port 80"| D["Azure Virtual Network<br/>10.0.0.0/16"]

    D --> E["Web Subnet<br/>10.0.1.0/24"]
    D --> F["App Subnet<br/>10.0.2.0/24"]

    F --> G["Ubuntu VM<br/>Ubuntu Server 24.04 LTS"]
    G --> H["Nginx Web Server"]
    H --> I["Custom HTML Website"]

    J["Administrator"] -->|"SSH - Port 22<br/>Authorized IP only"| C

    K["Terraform"] -->|"Infrastructure as Code"| D
    K --> G
```

## Component Descriptions

| Component | Purpose |
|---|---|
| Azure Public IP | Provides a public endpoint for accessing the website |
| Network Security Group | Controls inbound network traffic |
| Virtual Network | Provides an isolated Azure network |
| Web Subnet | Reserved subnet for web-tier resources |
| App Subnet | Hosts the Ubuntu virtual machine |
| Ubuntu VM | Provides the Linux hosting environment |
| Nginx | Serves the website over HTTP |
| Terraform | Provisions and manages infrastructure |

## Network Security

- HTTP traffic is permitted through port 80.
- SSH administrative access uses port 22 and is restricted to an authorized IP address.
- SSH authentication uses an SSH key rather than a password.

## Deployment Notes

- Infrastructure is provisioned using Terraform.
- The Ubuntu virtual machine runs Nginx.
- The custom HTML website is hosted on the virtual machine.
- HTTPS and additional cloud-native improvements are planned.
