# Azure Cloud Security & IAM Lab — Project Journal

This journal documents the work completed during the **Azure Cloud Security & IAM Lab** for the fictional organization **Wu Industries**.

The purpose of this journal is to track completed work, technical decisions, troubleshooting, security concepts, evidence, and lessons learned throughout the project.

Only work that has actually been completed is recorded as completed.

---

# Session 1 — August 24, 2026

## Phase

**Phase 0 — Account Setup, Cost Protection, Planning, and GitHub Foundation**

## Objective

Establish a safe and organized foundation for the Azure security lab before deploying cloud infrastructure.

## Completed

- Activated an **Azure for Students** subscription.
- Confirmed access to the Azure Portal.
- Created a **$10 monthly Azure budget** to help monitor lab spending.
- Configured budget alert thresholds.
- Selected **Wu Industries** as the fictional organization for the lab.
- Defined the initial company departments and user roles.
- Planned the initial Azure network architecture.
- Established an Azure resource naming convention.
- Created the GitHub repository:
  - `azure-cloud-security-iam-lab`
- Created the initial project `README.md`.
- Created the initial architecture documentation:
  - `docs/architecture.md`
- Created the project journal:
  - `docs/project-journal.md`

## Company Scenario

**Wu Industries** is a fictional small business being used to simulate a realistic Azure cloud environment.

The company will eventually use Azure resources, Microsoft Entra ID, networking, IAM, security controls, logging, monitoring, and automation.

## Planned Departments

- IT / Cloud Administration
- Cybersecurity
- Finance
- Human Resources
- Operations

## Planned Identity Roles

The environment is planned to include fictional users representing the following roles:

- Cloud Administrator
- Security Analyst
- IT Support Specialist
- Finance Employee
- Human Resources Employee
- Operations Employee

These roles will eventually be used to practice:

- Identity and Access Management
- Azure RBAC
- Group-based access
- Least privilege
- Separation of duties
- Excessive-permission identification

## Initial Network Plan

The initial Wu Industries network design uses the following private address space:

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
- Security configuration exercises

## Initial Resource Naming Convention

The original naming plan used South Central US:

| Resource | Original Planned Name |
|---|---|
| Resource Group | `rg-ci-securitylab-scus` |
| Virtual Network | `vnet-ci-securitylab-scus` |
| Management Subnet | `snet-management` |
| Workload Subnet | `snet-workload` |
| Management NSG | `nsg-management` |
| Workload NSG | `nsg-workload` |
| Windows VM | `vm-ci-win01` |
| Linux VM | `vm-ci-linux01` |

The region naming convention was later revised after an Azure Policy restriction was discovered during deployment.

## Technologies Used

- Microsoft Azure
- Azure for Students
- Azure Cost Management
- GitHub
- Git
- Markdown

## Security and Governance Concepts Reviewed

- Cloud cost management
- Resource organization
- Network segmentation
- Identity and Access Management planning
- Role-Based Access Control planning
- Least privilege
- Separation of duties
- Cloud resource naming
- Documentation
- Portfolio evidence management

## GitHub Files Created

- `README.md`
- `docs/architecture.md`
- `docs/project-journal.md`

## Phase 0 Result

Phase 0 established the planning, cost-management, documentation, and GitHub foundation required before deploying the Wu Industries Azure environment.

---

# Session 2 — August 25, 2026

## Phase

**Phase 1 — Azure Foundation**

## Objective

Begin deploying the Wu Industries Azure environment and validate that the planned architecture can be deployed within the restrictions of the Azure for Students subscription.

## Resource Group Deployment

The first Azure resource created for the project was:

`rg-ci-securitylab-scus`

The resource group was created in:

**South Central US**

The following tags were applied:

| Tag | Value |
|---|---|
| Organization | Wu Industries |
| Environment | Lab |
| Project | Azure-Cloud-Security-IAM |

The resource group was successfully deployed and contained no additional resources at the time of creation.

## Why Resource Groups Matter

The resource group provides a logical container for the Azure resources associated with the Wu Industries security lab.

Using a dedicated resource group helps support:

- Resource organization
- Asset identification
- Lifecycle management
- Cost tracking
- Access management
- Cloud governance

## Evidence Captured

A screenshot was captured showing the successfully deployed resource group and its organizational tags.

Evidence filename:

`01-resource-group-created.png`

The subscription identifier was hidden before the screenshot was retained for potential portfolio use.

## Virtual Network Deployment Attempt

The next planned resource was the Wu Industries Virtual Network.

The following configuration was prepared:

### Virtual Network

`vnet-ci-securitylab-scus`

### Address Space

`10.10.0.0/16`

### Management Subnet

`10.10.1.0/24`

### Workload Subnet

`10.10.2.0/24`

Additional paid or unnecessary networking services were left disabled.

The proposed VNet configuration itself passed the initial design review, but Azure blocked the deployment during validation.

## Troubleshooting

### Issue — Virtual Network Deployment Blocked by Azure Policy

When the Virtual Network deployment was submitted using **South Central US**, Azure returned a deployment validation failure.

The error indicated that the deployment was blocked because of an **Azure Policy violation**.

This showed that the issue was not necessarily caused by the VNet address space or subnet configuration.

### Investigation

Instead of repeatedly modifying the network configuration, the subscription's Azure Policy assignments were reviewed.

The Azure for Students subscription contained a restriction controlling which Azure regions could be used for resource deployment.

The allowed regions were identified as:

- West US
- Canada Central
- Norway East
- Belgium Central
- Mexico Central

South Central US was not included in the permitted deployment regions.

### Root Cause

The VNet deployment failed because **South Central US was not an allowed deployment region under the Azure Policy assigned to the Azure for Students subscription**.

The planned network configuration was therefore technically valid but did not comply with the subscription-level governance policy.

### Resolution Decision

**West US** was selected as the new deployment region for the Wu Industries lab.

The region abbreviation used in the resource naming convention will change from:

`scus`

to:

`wus`

This keeps resource names consistent with the actual deployment region.

## Revised Resource Naming

The updated naming convention is:

| Resource | Revised Name |
|---|---|
| Resource Group | `rg-ci-securitylab-wus` |
| Virtual Network | `vnet-ci-securitylab-wus` |
| Management Subnet | `snet-management` |
| Workload Subnet | `snet-workload` |
| Management NSG | `nsg-management` |
| Workload NSG | `nsg-workload` |
| Windows VM | `vm-ci-win01` |
| Linux VM | `vm-ci-linux01` |

The network address design remains unchanged:

- VNet: `10.10.0.0/16`
- Management Subnet: `10.10.1.0/24`
- Workload Subnet: `10.10.2.0/24`

## Security and Governance Concepts Learned

This troubleshooting process introduced an important cloud-governance concept:

### Azure Policy

Azure Policy can enforce organizational or subscription-level requirements that determine which configurations are permitted.

A resource configuration can be technically valid but still fail deployment if it violates an assigned policy.

This demonstrates how cloud environments can enforce controls such as:

- Allowed deployment regions
- Required resource configurations
- Required tags
- Security standards
- Compliance requirements

## Troubleshooting Process Used

The issue was approached using the following process:

**Deployment Failure → Review Error → Identify Policy Violation → Inspect Azure Policy → Determine Allowed Regions → Select Compliant Region → Update Architecture**

This avoided randomly changing the network configuration and helped identify the actual root cause.

## What I Learned

This was the first significant troubleshooting issue encountered during the project.

The main lesson was that cloud deployment failures are not always caused by incorrect technical configuration.

Azure governance controls can restrict what users are allowed to deploy even when the underlying resource configuration is otherwise valid.

Reviewing the policy assignment made it possible to determine the actual restriction and redesign the deployment to comply with it.

The experience also demonstrated why it is important to verify subscription restrictions before finalizing cloud architecture and naming conventions.

## GitHub Documentation Updated

The following project documentation is being updated to reflect the region change:

- `docs/architecture.md`
- `docs/project-journal.md`

The architecture is being changed from **South Central US** to **West US** before additional infrastructure is deployed.

## Current Status

The original South Central US resource group was successfully created, but the planned Virtual Network deployment was blocked by the Azure for Students allowed-region policy.

The Azure Policy restriction has been investigated and understood.

**West US has been selected as the new deployment region.**

The VNet and subnets have **not yet been successfully deployed**.

## Next Steps

1. Remove the unused South Central US resource group once appropriate.
2. Create the Wu Industries resource group in West US:
   - `rg-ci-securitylab-wus`
3. Verify the organizational tags.
4. Deploy the Virtual Network:
   - `vnet-ci-securitylab-wus`
5. Configure:
   - `snet-management` — `10.10.1.0/24`
   - `snet-workload` — `10.10.2.0/24`
6. Verify the successful VNet deployment.
7. Capture portfolio evidence.
8. Update the project journal with the successful deployment.
9. Continue into Azure network security configuration.
---

# Session 3 — September 20, 2026

## Phase

**Phase 1 — Azure Foundation**

## Objective

Deploy and validate the core Azure networking foundation for the Wu Industries cloud security lab.

## Completed

- Confirmed the West US resource group:
  - `rg-wi-securitylab-wus`
- Verified organizational tags:
  - Organization: `Wu Industries`
  - Environment: `Lab`
  - Project: `Azure-Cloud-Security-IAM`
- Created the Azure Virtual Network:
  - `vnet-wi-securitylab-wus`
- Deployed the Virtual Network in:
  - `West US`
- Configured the VNet address space:
  - `10.10.0.0/16`
- Created the management subnet:
  - `snet-management`
  - `10.10.1.0/24`
- Created the workload subnet:
  - `snet-workload`
  - `10.10.2.0/24`
- Verified both subnets were successfully deployed.
- Azure Bastion was left disabled.
- Azure Firewall was left disabled.
- Azure DDoS Network Protection was left disabled.

## Evidence Captured

- `docs/evidence/02-vnet-created.png`
- `docs/evidence/03-subnets-created.png`

## Security Concepts Practiced

- Azure Virtual Network deployment
- Network segmentation
- Private IPv4 addressing
- Subnet design
- Resource organization
- Cloud cost awareness

## Current Status

The Wu Industries Azure networking foundation has been successfully deployed in West US.

Current network configuration:

- VNet: `vnet-wi-securitylab-wus`
- Address space: `10.10.0.0/16`
- Management subnet: `10.10.1.0/24`
- Workload subnet: `10.10.2.0/24`

The next stage of the project is network security configuration using Azure Network Security Groups.

## Next Steps

1. Create `nsg-management`.
2. Create `nsg-workload`.
3. Associate each NSG with its corresponding subnet.
4. Configure and document network security rules.
5. Validate the resulting network security configuration.
---

# Session 4 — September 20, 2026

## Phase

**Phase 2 — Network Security Configuration**

## Objective

Implement subnet-level network security controls for the Wu Industries Azure environment using Network Security Groups.

## Completed

- Created the management Network Security Group:
  - `nsg-management`
- Created the workload Network Security Group:
  - `nsg-workload`
- Associated:
  - `nsg-management` with `snet-management`
  - `nsg-workload` with `snet-workload`

### Management Subnet Security

Configured `nsg-management` with the following inbound rule:

- `Deny-Workload-to-Management`
  - Priority: `200`
  - Source: `10.10.2.0/24`
  - Protocol: `Any`
  - Destination port: `Any`
  - Action: `Deny`

This prevents systems in the workload subnet from initiating connections into the management subnet.

### Workload Subnet Security

Configured `nsg-workload` with the following inbound rules:

- `Allow-Management-SSH`
  - Priority: `100`
  - Source: `10.10.1.0/24`
  - Protocol: `TCP`
  - Destination port: `22`
  - Action: `Allow`

- `Allow-Management-RDP`
  - Priority: `110`
  - Source: `10.10.1.0/24`
  - Protocol: `TCP`
  - Destination port: `3389`
  - Action: `Allow`

- `Deny-Other-VNet-Inbound`
  - Priority: `200`
  - Source: `VirtualNetwork`
  - Protocol: `Any`
  - Destination port: `Any`
  - Action: `Deny`

## Security Design

The management subnet is permitted to initiate SSH and RDP connections to workloads.

The workload subnet is prevented from initiating connections into the management subnet.

This configuration demonstrates network segmentation and least-privilege access between Azure subnets.

## Evidence Captured

- `docs/evidence/04-nsg-management-rules.png`
- `docs/evidence/05-nsg-workload-rules.png`

## Security Concepts Practiced

- Network Security Groups
- Inbound security rules
- Rule priority
- Network segmentation
- Least privilege
- Administrative access control
- Subnet-level security

## Current Status

The Wu Industries virtual network and subnet security controls are now deployed.

The next stage is to deploy workloads and validate the network security rules using actual systems.

## Next Steps

1. Deploy test workloads.
2. Place workloads in the appropriate subnets.
3. Test allowed management traffic.
4. Test blocked workload-to-management traffic.
5. Document validation results.
