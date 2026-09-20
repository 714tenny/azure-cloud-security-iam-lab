# Wu Industries — Azure Architecture

## Status

**Azure Foundation — Partially Deployed**

The core Wu Industries network infrastructure has been successfully deployed in West US.

### Deployed Resources

- Resource Group: `rg-wi-securitylab-wus`
- Virtual Network: `vnet-wi-securitylab-wus`
- Address Space: `10.10.0.0/16`
- Management Subnet: `snet-management` — `10.10.1.0/24`
- Workload Subnet: `snet-workload` — `10.10.2.0/24`

Network Security Groups, workloads, identity controls, monitoring, and additional security configurations will be added in later phases.

- Management NSG: `nsg-management` — associated with `snet-management`
- Workload NSG: `nsg-workload` — associated with `snet-workload`
## Organization

Wu Industries is a fictional small-business environment with the following departments:

- IT / Cloud Administration
- Cybersecurity
- Finance
- Human Resources
- Operations

##  Azure Environment

The initial environment is planned to contain:

- Azure for Students subscription
- Resource group
- Azure Virtual Network
- Management subnet
- Workload subnet
- Network Security Groups
- Windows and/or Linux workloads
- Microsoft Entra ID users and groups
- Azure RBAC assignments
- Azure logging and monitoring

## Network Design
## Network Security Design

### Management Subnet

`nsg-management` protects `snet-management`.

Custom inbound control:

- Deny traffic initiated from `10.10.2.0/24` (workload subnet) to the management subnet.

### Workload Subnet

`nsg-workload` protects `snet-workload`.

Custom inbound controls:

- Allow SSH (TCP 22) from `10.10.1.0/24`
- Allow RDP (TCP 3389) from `10.10.1.0/24`
- Deny all other Virtual Network inbound traffic

This design allows explicitly authorized administrative access from the management subnet while preventing the workload subnet from initiating connections into the management subnet.
### Virtual Network

`10.10.0.0/16`

### Management Subnet

`10.10.1.0/24`

Purpose:

- Administrative resources
- Management-related systems
- Restricted administrative access

### Workload Subnet

`10.10.2.0/24`

Purpose:

- Business workloads
- Test systems
- Security configuration and monitoring exercises

## Planned Resource Naming

| Resource | Planned Name |
|---|---|
| Resource Group | `rg-wi-securitylab-wus` |
| Virtual Network | `vnet-wi-securitylab-wus` |
| Management Subnet | `snet-management` |
| Workload Subnet | `snet-workload` |
| Management NSG | `nsg-management` |
| Workload NSG | `nsg-workload` |
| Windows VM | `vm-wi-win01` |
| Linux VM | `vm-wi-linux01` |

## Security Design Goals

The environment will be designed to explore:

- Network segmentation
- Least privilege
- Role-Based Access Control
- Group-based access management
- Separation of duties
- Network access controls
- Security logging
- Misconfiguration identification
- Risk assessment
- Remediation and validation

## Architecture Diagram

A final architecture diagram will be added after the environment has actually been deployed and validated.

