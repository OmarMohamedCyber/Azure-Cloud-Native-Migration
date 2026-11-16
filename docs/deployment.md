# Terraform Deployment Process

## Overview

Terraform was used to provision the cloud infrastructure for this Azure
Cloud-Native Migration project.

Infrastructure as Code (IaC) allows infrastructure to be defined,
deployed, and managed through configuration files rather than manually
creating every resource through the Azure Portal.

## Terraform and Azure Integration

Terraform communicates with Microsoft Azure through the AzureRM
provider.

The AzureRM provider translates Terraform configuration into requests
that Azure can process to create and manage cloud resources.

## Deployment Workflow

The following Terraform commands were used during deployment:

  -----------------------------------------------------------------------
  Command                             Purpose
  ----------------------------------- -----------------------------------
  `terraform init`                    Initializes the Terraform working
                                      directory and downloads the
                                      required Azure provider

  `terraform validate`                Checks the Terraform configuration
                                      for errors

  `terraform plan`                    Previews the infrastructure changes
                                      before deployment

  `terraform apply`                   Applies the configuration and
                                      provisions Azure resources
  -----------------------------------------------------------------------

## Infrastructure Provisioned

Terraform configuration files were used to deploy the following Azure
infrastructure:

-   Azure Resource Group
-   Azure Virtual Network
-   Web and application subnets
-   Network Security Group
-   Static Public IP address
-   Network Interface
-   Ubuntu Linux Virtual Machine

The infrastructure was deployed in the East US Azure region.

## Linux Server Configuration

After the virtual machine was provisioned, SSH key-based authentication
was used to connect to the Ubuntu Server 24.04 LTS environment.

The server was updated and configured with Nginx to host a custom HTML
website.

The HTTP inbound security rule was configured through the Azure CLI.

## Infrastructure Management

Terraform uses a state file to track the infrastructure it manages.

The state file helps Terraform identify existing resources and determine
what changes are necessary during future deployments.

Terraform configuration files are maintained in GitHub to support
version control and documentation.

Sensitive state files and credentials are excluded from version control.

## Outcome

The project demonstrates practical experience with:

-   Infrastructure as Code
-   Terraform and Azure integration
-   Azure resource provisioning
-   Cloud networking
-   Linux virtual machine deployment
-   SSH administration
-   Nginx web server configuration
-   Git and GitHub version control
