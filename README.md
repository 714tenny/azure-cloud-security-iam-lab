# Azure Cloud Security & IAM Lab

## Overview

This project is a hands-on Microsoft Azure cloud security lab built around a fictional small-business environment called **Wu Industries**.

The goal of the lab was to design, deploy, secure, assess, monitor, remediate, and automate a small Azure environment while developing practical experience with:

- Azure networking
- Network Security Groups
- Identity and Access Management
- Azure Role-Based Access Control
- Least privilege
- Security misconfiguration analysis
- Risk assessment
- Remediation
- Azure Activity Log
- Azure CLI
- Bash automation
- Technical documentation
- Git and GitHub

The project focused not only on deploying Azure resources, but also on understanding why security controls are used, identifying insecure configurations, correcting them, and validating the final secure state.

---

## Current Status

**Project Complete — Final Security Assessment and Portfolio Documentation**

The Wu Industries Azure environment has been:

- Planned
- Deployed
- Secured
- Assessed
- Remediated
- Validated
- Monitored
- Automated
- Documented

All intentionally introduced security misconfigurations were removed before completion.

---

## Business Scenario

**Wu Industries** is a fictional small business used to simulate a realistic Azure cloud environment.

The environment was designed around several business functions:

- IT / Cloud Administration
- Cybersecurity
- Finance
- Human Resources
- Operations

The lab demonstrates how Azure networking, managed identities, RBAC, security controls, logging, and automation can be used to support a small organization.

---

## Azure Environment

### Subscription

Azure for Students

### Region

`West US`

### Resource Group

`rg-wi-securitylab-wus`

### Virtual Network

`vnet-wi-securitylab-wus`

Address space:

`10.10.0.0/16`

### Subnets

Management subnet:

- `snet-management`
- `10.10.1.0/24`

Workload subnet:

- `snet-workload`
- `10.10.2.0/24`

### Network Security Groups

- `nsg-management`
- `nsg-workload`

### Test Network Interfaces

- `nic-wi-mgmt01`
- `nic-wi-workload01`

### Managed Identities

- `mi-wi-security-audit`
- `mi-wi-network-operator`

---

## Network Security Design

The environment uses subnet-level Network Security Groups to enforce segmentation between the management and workload networks.

### Management Subnet

`nsg-management` protects `snet-management`.

Custom rule:

- `Deny-Workload-to-Management`
- Priority: `200`
- Source: `10.10.2.0/24`
- Protocol: `Any`
- Destination port: `Any`
- Action: `Deny`

This prevents systems in the workload subnet from initiating connections into the management subnet.

### Workload Subnet

`nsg-workload` protects `snet-workload`.

Custom rules:

- `Allow-Management-SSH`
  - Priority: `100`
  - Source: `10.10.1.0/24`
  - Protocol: `TCP`
  - Port: `22`
  - Action: `Allow`

- `Allow-Management-RDP`
  - Priority: `110`
  - Source: `10.10.1.0/24`
  - Protocol: `TCP`
  - Port: `3389`
  - Action: `Allow`

- `Deny-Other-VNet-Inbound`
  - Priority: `200`
  - Source: `VirtualNetwork`
  - Protocol: `Any`
  - Port: `Any`
  - Action: `Deny`

This configuration demonstrates:

- Network segmentation
- Restricted administrative access
- Least privilege
- Subnet-level security controls

---

## Identity and Access Management

Microsoft Entra ID tenant-level user and group administration was unavailable because the Azure for Students subscription was associated with a university-managed directory.

Instead of attempting to bypass those restrictions, the project used Azure user-assigned managed identities to demonstrate RBAC and least-privilege concepts.

### Security Audit Identity

`mi-wi-security-audit`

Assigned role:

`Reader`

Purpose:

Provide read-only access to Azure resources.

### Network Operator Identity

`mi-wi-network-operator`

Assigned role:

`Network Contributor`

Purpose:

Allow management of Azure networking resources without granting broad Owner or Contributor-level permissions.

This demonstrates:

- Azure RBAC
- Least privilege
- Separation of duties
- Job-function-based access
- Resource-group-scoped permissions

---

## Security Assessment Methodology

Security findings followed the process:

**Identify → Assess Risk → Remediate → Validate → Document**

Each finding included:

1. Identification of the insecure configuration
2. Risk assessment
3. Remediation
4. Validation of the corrected state
5. Supporting evidence

---

## Key Security Findings

### Finding 001 — Overly Permissive SSH Access

A temporary NSG rule was created that allowed SSH access from any source.

Temporary rule:

- `TEMP-Allow-SSH-Any`
- Source: `Any`
- Protocol: `TCP`
- Port: `22`
- Action: `Allow`

### Risk

**High**

Potential risks included:

- Unauthorized SSH connection attempts
- Brute-force attacks
- Credential attacks
- Increased administrative attack surface

### Remediation

The temporary rule was removed.

SSH access remained restricted to:

`10.10.1.0/24`

through:

`Allow-Management-SSH`

### Validation

Azure CLI confirmed that:

- `TEMP-Allow-SSH-Any` was removed
- SSH remained restricted to the management subnet

### Final Status

**Remediated and Validated**

---

### Finding 002 — Excessive RBAC Permissions

The network operator managed identity was temporarily assigned the broad:

`Contributor`

role in addition to its intended:

`Network Contributor`

role.

### Risk

**High**

Potential risks included:

- Modification of unrelated Azure resources
- Accidental resource deletion
- Excessive permissions
- Increased impact if the identity were compromised
- Reduced separation of duties

### Remediation

The broad `Contributor` role was removed.

The identity retained only:

`Network Contributor`

### Validation

Azure CLI confirmed that:

- `Contributor` was removed
- `Network Contributor` remained assigned

### Final Status

**Remediated and Validated**

---

## Logging and Security Investigation

Azure Activity Log was used to investigate security-relevant administrative actions.

The Activity Log confirmed:

- Removal of the excessive RBAC role assignment
- Removal of the temporary overly permissive SSH rule

This demonstrated the ability to use Azure logging to correlate administrative changes with security findings and remediation actions.

---

## Azure CLI Validation

Azure Cloud Shell and Azure CLI were used throughout the project to verify deployed configurations.

CLI validation included:

- Subnet-to-NSG associations
- NSG rules
- Managed identity RBAC assignments
- Removal of the temporary SSH rule
- Removal of the broad Contributor role

This provided direct control-plane validation of the final Azure configuration.

---

## Security Automation

A Bash-based Azure CLI security review script was created:

`scripts/azure-security-review.sh`

The script automatically reviews:

- Resource group information
- Virtual Network configuration
- Subnet and NSG associations
- Management NSG rules
- Workload NSG rules
- Managed identity RBAC assignments
- SSH source restrictions
- Presence of temporary insecure SSH rules
- Excessive Contributor permissions

Final automated checks returned:

- `[PASS] SSH is restricted to the management subnet.`
- `[PASS] Temporary unrestricted SSH rule is not present.`
- `[PASS] Broad Contributor role is not assigned to the network operator.`

---

## Architecture Diagram

A visual architecture diagram is available in:

[Architecture Documentation](docs/architecture.md)

The deployed environment includes:

- Azure for Students
- Wu Industries resource group
- Azure Virtual Network
- Management and workload subnets
- Network Security Groups
- Test network interfaces
- Managed identities
- Azure RBAC
- Azure Activity Log
- Azure CLI security automation

---

## Environment Constraints

### Microsoft Entra ID

The subscription was connected to a university-managed Microsoft Entra ID directory.

Tenant-level Entra user and group management was therefore unavailable.

Managed identities were used instead to demonstrate Azure IAM and RBAC concepts.

### Virtual Machines

Live VM-based packet-flow testing was not performed because an eligible free-tier VM size was unavailable in the selected Azure region.

To avoid unnecessary cloud costs, paid virtual machines were not deployed.

The project therefore does not claim that live SSH, RDP, or blocked packet flows were tested.

Network and IAM controls were instead validated using:

- Azure Portal
- Azure CLI
- Azure Activity Log
- Automated Bash security checks

---

## Cost Management

The project was built using an **Azure for Students** subscription with an emphasis on minimizing unnecessary cloud costs.

Paid or unnecessary services were avoided where possible.

The project demonstrates cost-aware cloud security engineering by adapting validation methods when free resources were unavailable.

---

## Project Phases

1. Azure account setup, cost protection, and planning
2. Azure foundation and resource organization
3. Virtual Network and subnet deployment
4. Network Security Group configuration
5. Network security validation
6. Identity and Azure RBAC
7. Security misconfiguration assessment
8. Remediation and validation
9. Logging and security investigation
10. Azure CLI and Bash automation
11. Final security assessment
12. Portfolio documentation and cleanup

---

## Skills Demonstrated

- Microsoft Azure
- Azure networking
- Virtual Networks
- Subnets
- Network Security Groups
- Network segmentation
- Azure RBAC
- Managed identities
- Least privilege
- Separation of duties
- Security misconfiguration analysis
- Risk assessment
- Security remediation
- Azure Activity Log
- Azure Cloud Shell
- Azure CLI
- Bash scripting
- Security automation
- Configuration validation
- Technical documentation
- Git
- GitHub

---

## Project Documentation

- [Architecture Documentation](docs/architecture.md)
- [Project Journal](docs/project-journal.md)
- [Security Findings](docs/security-findings.md)
- [Final Security Assessment](docs/final-security-assessment.md)
- [Evidence Screenshots](docs/evidence/)
- [Azure Security Review Script](scripts/azure-security-review.sh)

---

## Final Result

The Wu Industries Azure Cloud Security & IAM Lab demonstrates the design, deployment, hardening, assessment, remediation, monitoring, and automated validation of a small Azure environment.

The final environment includes segmented networking, subnet-level security controls, least-privilege RBAC, managed identities, administrative audit logging, Azure CLI validation, and automated security checks.

All intentionally introduced security misconfigurations were remediated before completion, leaving the environment in its intended secured state.
