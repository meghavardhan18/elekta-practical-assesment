# Elekta DevOps Practical Assessment

## Overview

This project is a Terraform-based Infrastructure as Code solution created for the Elekta DevOps Practical Assessment.

The goal of this project is to provision Azure infrastructure using Terraform and support the deployment through an Azure DevOps CI/CD pipeline. The infrastructure includes a resource group, virtual network, subnet, network security group, public IPs, network interfaces, and two Windows Server 2022 virtual machines.

This solution demonstrates Infrastructure as Code, source control organization, Terraform validation, planning, deployment automation, and basic Azure infrastructure design.

---

## Assessment Requirements Covered

This project covers the following requirements:

- Create a Resource Group named `elekta-devops-test`
- Create a Virtual Network with address space `10.0.0.0/16`
- Create a Subnet with address range `10.0.1.0/24`
- Create a Network Security Group allowing RDP access on port `3389`
- Create two Windows Server 2022 virtual machines
- VM names:
  - `vm-test-1`
  - `vm-test-2`
- Configure admin username as `Elekta`
- Assign public IPs for external access
- Allow both VMs to communicate within the same subnet
- Output VM names, public IPs, private IPs, and resource group name
- Organize Terraform files clearly
- Include Azure DevOps pipeline configuration
- Document deployment steps, assumptions, security considerations, and design decisions

---

## Folder Structure

```text
elekta-devops-assessment/
├── README.md
├── azure-pipelines.yml
└── terraform/
    ├── providers.tf
    ├── resource_group.tf
    ├── network.tf
    ├── nsg.tf
    ├── vm.tf
    ├── variables.tf
    ├── terraform.tfvars
    └── outputs.tf
```

---

## Terraform File Explanation

### `providers.tf`

Defines the Terraform AzureRM provider configuration used to connect Terraform with Microsoft Azure.

### `resource_group.tf`

Creates the Azure Resource Group used to logically group all assessment resources.

Resource Group:

```text
elekta-devops-test
```

### `network.tf`

Creates the Azure networking components:

- Virtual Network
- Subnet

Virtual Network:

```text
elekta-VNet
```

VNet address space:

```text
10.0.0.0/16
```

Subnet:

```text
elekta-subnet1
```

Subnet address range:

```text
10.0.1.0/24
```

Both virtual machines are deployed into the same subnet, which allows private communication between them.

### `nsg.tf`

Creates the Network Security Group and associates it with the subnet.

Network Security Group:

```text
elekta-NSG
```

The NSG includes an inbound rule to allow RDP traffic:

```text
Port: 3389
Protocol: TCP
Direction: Inbound
Access: Allow
```

This rule is included because the assessment requires external RDP access to the Windows virtual machines.

### `vm.tf`

Creates the virtual machine-related resources:

- Two public IP addresses
- Two network interfaces
- Two Windows Server 2022 virtual machines

Virtual machine names:

```text
vm-test-1
vm-test-2
```

Windows image:

```text
Windows Server 2022 Datacenter
```

Each VM is attached to its own network interface and public IP address.

### `variables.tf`

Defines reusable input variables such as:

- Resource group name
- Azure region
- VNet name
- Subnet name
- NSG name
- Public IP name prefix
- NIC name prefix
- VM name prefix
- Admin username
- Admin password

The password variable is marked as sensitive.

### `terraform.tfvars`

Provides actual values for the Terraform variables.

Values used:

```text
resource_group_name   = "elekta-devops-test"
location              = "Central India"
VNET_name             = "elekta-VNet"
Subnet_name           = "elekta-subnet1"
NSG_name              = "elekta-NSG"
public_ip_name_prefix = "elekta-public-ip"
nic_name_prefix       = "elekta-nic"
vm_name_prefix        = "vm-test"
user_name             = "Elekta"
```

The password value is used for local assessment testing. In a production environment, this should be stored in Azure Key Vault or Azure DevOps secure variables.

### `outputs.tf`

Displays important deployment information after Terraform apply, including:

- Resource group name
- VM name
- Public IP address
- Private IP address

Outputs included:

```text
VM_Test_1
VM_Test_2
```

These outputs make it easy to validate the deployed infrastructure.

---

## Prerequisites

Before running this project, the following are required:

- Azure subscription
- Azure CLI installed
- Terraform installed
- Git installed
- Azure DevOps project
- Azure DevOps service connection to Azure

---

## Azure Authentication

Login to Azure from the local machine:

```bash
az login
```

Verify the active subscription:

```bash
az account show
```

If multiple subscriptions are available, set the correct subscription:

```bash
az account set --subscription "<subscription-name-or-id>"
```

---

## Terraform Deployment Steps

Navigate to the Terraform directory:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Format Terraform files:

```bash
terraform fmt
```

Validate Terraform configuration:

```bash
terraform validate
```

Review the deployment plan:

```bash
terraform plan
```

Apply the Terraform configuration:

```bash
terraform apply
```

Confirm by typing:

```text
yes
```

---

## Terraform Outputs

After successful deployment, Terraform displays output values for:

```text
VM_Test_1
VM_Test_2
```

Each output includes:

- Resource group name
- VM name
- Public IP address
- Private IP address

These outputs are used to validate VM deployment and connectivity.

---

## RDP Validation

Each VM has a public IP address for RDP access.

Validation approach:

1. Use the public IP of `vm-test-1` to connect through RDP.
2. Use the public IP of `vm-test-2` to connect through RDP.
3. Since both VMs are deployed in the same subnet, they can communicate privately.
4. Internal VM-to-VM communication can be tested using the private IP addresses shown in Terraform outputs.

---

## Azure DevOps Pipeline

The `azure-pipelines.yml` file defines the CI/CD pipeline for Terraform.

Pipeline stages:

1. Terraform Init
2. Terraform Format Check
3. Terraform Validate
4. Terraform Plan
5. Terraform Apply

The pipeline helps automate infrastructure validation and deployment. In a production environment, the apply stage should be protected with manual approval before infrastructure changes are deployed.

---

## Terraform State Management

Terraform state tracks the Azure resources created by Terraform.

For local testing, Terraform can use local state. For a team or production environment, Terraform state should be stored remotely in Azure Storage.

Recommended backend design:

- Azure Storage Account
- Blob Container
- Terraform state file stored securely as a blob

Benefits of remote state:

- Centralized state management
- Better team collaboration
- Safer pipeline execution
- Reduced risk of local state loss
- Supports locking and consistency

---

## Security Considerations

The following security considerations were included:

- Admin password is defined as a sensitive Terraform variable.
- RDP access is allowed because the assessment requires external VM access.
- In production, RDP should be restricted to a trusted IP range.
- Azure Bastion can be used instead of exposing RDP directly to the internet.
- Secrets should be stored in Azure Key Vault or Azure DevOps secure variables.
- Terraform state should be stored remotely and securely.
- Small VM sizes are used to reduce assessment cost.
- Resources should be destroyed after testing to avoid unnecessary Azure charges.

---

## Assumptions

The following assumptions were made:

- The infrastructure is created for assessment and demonstration purposes.
- Both VMs are deployed in the same subnet to allow private communication.
- Public IPs are included because the assessment requires external access.
- RDP access is enabled for validation.
- The deployment uses a single Azure region.
- Azure DevOps is used for CI/CD automation.
- Remote state storage is recommended for production-like usage.
- The environment should be destroyed after validation to avoid unnecessary cost.

---

## Cleanup

To avoid unnecessary Azure charges, destroy the infrastructure after testing:

```bash
terraform destroy
```

Confirm by typing:

```text
yes
```
This removes all resources created by Terraform.

---
## Design Summary

This solution provisions Azure infrastructure using Terraform and organizes the code into separate files for provider configuration, resource group, networking, security, virtual machines, variables, and outputs.

The Azure DevOps pipeline supports automated Terraform validation, planning, and deployment. The solution also includes documentation for deployment, state management, security considerations, assumptions, and cleanup.

This approach provides a repeatable, version-controlled, and automated infrastructure deployment workflow suitable for a DevOps environment.