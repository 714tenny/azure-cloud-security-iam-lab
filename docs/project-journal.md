# Azure Cloud Security & IAM Lab — Project Journal

This journal documents the work completed during the Azure Cloud Security & IAM Lab for the fictional organization **Chavez Industries**.

Only tasks that were actually completed are recorded here.

---

## Session 1 — August 24, 2026

### Phase
Phase 0 — Account Setup, Cost Protection, Planning, and GitHub Foundation

### Objective
Establish the foundation for the Azure security lab before deploying cloud infrastructure.

### Completed

- Activated an Azure for Students subscription.
- Selected **Chavez Industries** as the fictional organization for the lab.
- Defined the initial company departments and user roles.
- Planned the initial Azure network architecture.
- Established an Azure resource naming convention.
- Created the GitHub repository `azure-cloud-security-iam-lab`.
- Created the initial project README.
- Created the initial Azure architecture documentation.

### Planned Company Departments

- IT / Cloud Administration
- Cybersecurity
- Finance
- Human Resources
- Operations

### Planned Network

- VNet: `10.10.0.0/16`
- Management Subnet: `10.10.1.0/24`
- Workload Subnet: `10.10.2.0/24`

### Planned Resource Naming

- Resource Group: `rg-ci-securitylab-scus`
- Virtual Network: `vnet-ci-securitylab-scus`
- Management Subnet: `snet-management`
- Workload Subnet: `snet-workload`
- Management NSG: `nsg-management`
- Workload NSG: `nsg-workload`
- Windows VM: `vm-ci-win01`
- Linux VM: `vm-ci-linux01`

### Technologies Used

- Microsoft Azure
- Azure for Students
- GitHub
- Markdown

### Security Concepts

- Cloud cost management
- Network segmentation
- Identity and Access Management planning
- Role-Based Access Control planning
- Least privilege
- Separation of duties
- Cloud resource organization

### GitHub Files Created

- `README.md`
- `docs/architecture.md`
- `docs/project-journal.md`

### Current Status

The Azure architecture has been planned, but infrastructure has not yet been deployed.

### Next Steps

- Confirm Azure cost protections.
- Finalize Phase 0.
- Begin building the Chavez Industries Azure environment.
---

# Session 2 — August 25, 2026

## Phase

Phase 1 — Azure Foundation

## Objective

Begin deploying the Chavez Industries Azure environment by creating the organizational container for the lab resources.

## Completed

- Created the Azure resource group `rg-ci-securitylab-scus`.
- Deployed the resource group in the South Central US region.
- Applied organizational tags for company, environment, and project identification.
- Verified that the resource group was successfully created and currently contains no deployed resources.

## Resource Configuration

| Setting | Value |
|---|---|
| Resource Group | `rg-ci-securitylab-scus` |
| Region | South Central US |
| Organization | Chavez Industries |
| Environment | Lab |
| Project | Azure-Cloud-Security-IAM |

## Security / Governance Concepts

- Resource organization
- Cloud asset identification
- Tagging and governance
- Resource lifecycle management
- Consistent naming conventions

## Evidence

- `01-resource-group-created.png`

## Current Status

The Chavez Industries Azure resource group is active and ready for infrastructure deployment.

## Next Step

Create the Chavez Industries Azure Virtual Network and initial subnet structure.
