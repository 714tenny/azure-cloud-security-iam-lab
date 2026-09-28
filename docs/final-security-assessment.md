# Wu Industries — Final Azure Security Assessment

## Executive Summary

This assessment summarizes the security configuration, findings, remediation activities, validation, monitoring, and automation completed during the Wu Industries Azure Cloud Security & IAM Lab.

Wu Industries is a fictional small-business environment created to practice hands-on Azure cloud security concepts including:

- Azure networking
- Network segmentation
- Network Security Groups
- Identity and Access Management
- Azure Role-Based Access Control
- Least privilege
- Security misconfiguration analysis
- Risk assessment
- Remediation
- Logging and monitoring
- Azure CLI validation
- Security automation

The environment was built using an Azure for Students subscription with an emphasis on minimizing cloud costs.

---

## Environment Overview

### Resource Group

`rg-wi-securitylab-wus`

### Region

`West US`

### Virtual Network

`vnet-wi-securitylab-wus`

Address space:

`10.10.0.0/16`

### Subnets

Management:

- `snet-management`
- `10.10.1.0/24`

Workload:

- `snet-workload`
- `10.10.2.0/24`

### Network Security Groups

- `nsg-management`
- `nsg-workload`

### Managed Identities

- `mi-wi-security-audit`
- `mi-wi-network-operator`

---

## Network Security Architecture

The environment uses subnet-level Network Security Groups to implement segmentation between management and workload resources.

### Management Subnet

`nsg-management` protects `snet-management`.

Custom security control:

- Deny inbound traffic initiated from the workload subnet:
  - Source: `10.10.2.0/24`
  - Action: `Deny`

### Workload Subnet

`nsg-workload` protects `snet-workload`.

Custom security controls:

- Allow SSH from management subnet:
  - Source: `10.10.1.0/24`
  - TCP `22`

- Allow RDP from management subnet:
  - Source: `10.10.1.0/24`
  - TCP `3389`

- Deny other Virtual Network inbound traffic.

This design demonstrates network segmentation and restricted administrative access.

---

## Identity and Access Management

Microsoft Entra ID tenant-level user administration was unavailable because the Azure for Students subscription was associated with a university-managed directory.

The project therefore used Azure user-assigned managed identities to demonstrate IAM and RBAC concepts without attempting to bypass directory restrictions.

### Security Audit Identity

`mi-wi-security-audit`

Role:

`Reader`

Purpose:

Provide read-only visibility into Azure resources.

### Network Operator Identity

`mi-wi-network-operator`

Role:

`Network Contributor`

Purpose:

Provide networking-management permissions without broad resource-management privileges.

This demonstrates:

- Least privilege
- Separation of duties
- Job-function-based access
- Resource-group-scoped RBAC

---

# Security Findings

## Finding 001 — Overly Permissive SSH Access

### Initial Condition

A temporary NSG rule allowed SSH access from any source:

- Rule: `TEMP-Allow-SSH-Any`
- Source: `Any`
- Protocol: `TCP`
- Port: `22`
- Action: `Allow`

### Risk

**High**

Allowing SSH from arbitrary sources increases the administrative attack surface and can expose systems to:

- Unauthorized connection attempts
- Brute-force attacks
- Credential attacks
- Untrusted networks

### Remediation

The temporary rule was deleted.

SSH access remained restricted to:

`10.10.1.0/24`

through:

`Allow-Management-SSH`

### Validation

Azure CLI validation confirmed that:

- `TEMP-Allow-SSH-Any` no longer existed.
- SSH remained restricted to the management subnet.

### Status

**Remediated and Validated**

---

## Finding 002 — Excessive RBAC Permissions

### Initial Condition

The network operator identity was temporarily assigned:

`Contributor`

in addition to its intended:

`Network Contributor`

role.

### Risk

**High**

The broad Contributor role granted permissions beyond the network operator's job requirements.

Potential impact included:

- Modification of unrelated Azure resources
- Accidental resource deletion
- Increased privileges if the identity were compromised
- Reduced separation of duties

### Remediation

The `Contributor` assignment was removed.

The identity retained only:

`Network Contributor`

### Validation

Azure CLI validation confirmed that the network operator retained `Network Contributor` and no longer had the broad `Contributor` role.

### Status

**Remediated and Validated**

---

## Logging and Security Investigation

Azure Activity Log was used to investigate security-relevant administrative changes.

Activity Log evidence confirmed:

- Removal of the excessive RBAC role assignment
- Removal of the overly permissive SSH rule

This demonstrated the ability to correlate configuration changes with Azure administrative audit events.

---

## Automated Security Validation

A Bash-based Azure CLI security review script was created:

`scripts/azure-security-review.sh`

The script performs repeatable reviews of:

- Resource group configuration
- Virtual Network configuration
- Subnet-to-NSG associations
- Management NSG rules
- Workload NSG rules
- Managed identity RBAC assignments
- SSH source restrictions
- Presence of temporary insecure SSH rules
- Excessive Contributor permissions

Final automated checks returned:

- `PASS` — SSH restricted to management subnet
- `PASS` — temporary unrestricted SSH rule absent
- `PASS` — broad Contributor role absent from network operator

---

## Validation Limitation

Live packet-flow testing between virtual machines was not performed.

An eligible free-tier virtual machine size was unavailable in the selected Azure region for the Azure for Students subscription.

To remain within the project's cost-management requirements, paid virtual machines were not deployed.

Network and IAM controls were instead validated through:

- Azure Portal configuration review
- Azure CLI
- Azure Activity Log
- Automated security-review scripting

The project does not claim that live SSH, RDP, or blocked packet flows were tested.

---

## Security Controls Implemented

The completed environment demonstrates:

- Private Azure Virtual Network design
- Network segmentation
- Subnet-level NSG enforcement
- Restricted administrative access
- RBAC
- Managed identities
- Least privilege
- Separation of duties
- Cloud configuration validation
- Administrative audit logging
- Security remediation
- Azure CLI automation
- Cost-aware cloud security engineering

---

## Assessment Methodology

Security findings followed the process:

**Identify → Assess Risk → Remediate → Validate → Document**

Each documented finding includes evidence of:

1. The insecure configuration
2. Risk analysis
3. Remediation
4. Validation of the secure final state

---

## Final Security Posture

At the conclusion of the assessment:

- The temporary unrestricted SSH rule had been removed.
- Administrative SSH access was restricted to the management subnet.
- Workload-to-management traffic remained restricted.
- The network operator no longer had excessive Contributor permissions.
- Managed identity permissions followed job-function requirements.
- NSG and RBAC configurations were validated through Azure CLI.
- Remediation actions were visible in Azure Activity Log.
- Automated security checks returned passing results.

The Wu Industries Azure environment was left in its intended secured state after all controlled security findings were remediated.

---

## Evidence

Supporting screenshots are located in:

`docs/evidence/`

Detailed security findings are documented in:

`docs/security-findings.md`

Implementation history is documented in:

`docs/project-journal.md`

Architecture documentation is located in:

`docs/architecture.md`

Automation is located in:

`scripts/azure-security-review.sh`
