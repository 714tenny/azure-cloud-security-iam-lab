# Wu Industries — Planned Azure Architecture

## Status

**Planning — Not Yet Deployed**

This document describes the initial architecture planned for the Chavez Industries Azure Cloud Security & IAM Lab. The architecture will be updated as resources are actually deployed and tested.

## Organization

Chavez Industries is a fictional small-business environment with the following departments:

- IT / Cloud Administration
- Cybersecurity
- Finance
- Human Resources
- Operations

## Planned Azure Environment

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

## Planned Network Design

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
| Resource Group | `rg-ci-securitylab-wus` |
| Virtual Network | `vnet-ci-securitylab-wus` |
| Management Subnet | `snet-management` |
| Workload Subnet | `snet-workload` |
| Management NSG | `nsg-management` |
| Workload NSG | `nsg-workload` |
| Windows VM | `vm-ci-win01` |
| Linux VM | `vm-ci-linux01` |

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

