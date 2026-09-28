# Azure Cloud Security & IAM Lab 

## Overview

This project is a hands-on Microsoft Azure cloud security lab built around a fictional small-business environment called **Wu Industries**.

The goal of the project is to design, deploy, secure, monitor, and assess an Azure environment while developing practical experience with cloud security, identity and access management, networking, security monitoring, risk assessment, remediation, and automation.

Rather than only deploying Azure resources, this project will focus on understanding why security controls are implemented, identifying security risks and misconfigurations, remediating those issues, and validating that the fixes are effective.

## Current Status

**Final Security Assessment and Portfolio Documentation**

The Wu Industries Azure Cloud Security & IAM Lab has been deployed, secured, assessed, remediated, validated, monitored, and automated.

### Completed

- Azure resource organization and tagging
- Virtual Network and subnet deployment
- Network Security Groups
- Network segmentation
- Managed identities
- Azure RBAC
- Least-privilege access
- Security misconfiguration assessment
- Risk analysis
- Remediation and validation
- Azure Activity Log investigation
- Azure CLI configuration validation
- Bash-based security review automation
- Final security assessment
- Architecture documentation

  ## Key Security Findings

### Finding 001 — Overly Permissive SSH Access

A temporary Network Security Group rule allowed SSH access from any source.

The rule was identified, assessed as high risk, removed, and validated through Azure CLI.

### Finding 002 — Excessive RBAC Permissions

The network operator identity was temporarily assigned the broad `Contributor` role.

The excessive assignment was removed and the identity retained only the more appropriate `Network Contributor` role.

Both findings followed the process:

**Identify → Assess Risk → Remediate → Validate → Document**
## Security Automation

A Bash-based Azure CLI security review script was created:

`scripts/azure-security-review.sh`

The script validates:

- Virtual Network configuration
- Subnet and NSG associations
- NSG security rules
- Managed identity RBAC assignments
- SSH source restrictions
- Removal of temporary insecure rules
- Removal of excessive Contributor permissions

  ## Project Documentation

- [Architecture](docs/architecture.md)
- [Project Journal](docs/project-journal.md)
- [Security Findings](docs/security-findings.md)
- [Final Security Assessment](docs/final-security-assessment.md)
- [Evidence](docs/evidence/)
- [Automation Script](scripts/azure-security-review.sh)

## Project Objectives

Planned areas of focus include:

- Microsoft Azure fundamentals
- Azure networking
- Virtual Networks and subnets
- Network Security Groups
- Microsoft Entra ID
- Identity and Access Management
- Azure Role-Based Access Control (RBAC)
- Least privilege
- Security misconfiguration analysis
- Risk assessment
- Security remediation and validation
- Azure logging and monitoring
- Security investigation
- PowerShell and Azure CLI automation
- Technical documentation
- Git and GitHub

## Business Scenario

**Wu Industries** is a fictional small business used to simulate a realistic Azure environment.

The organization will include several departments and user roles:

- IT / Cloud Administration
- Cybersecurity
- Finance
- Human Resources
- Operations

Different users and groups will receive different levels of access so that IAM, RBAC, least privilege, and separation-of-duties concepts can be tested.

## Architecture

The initial environment is planned to include:

- Azure subscription
- Resource group
- Azure Virtual Network
- Management subnet
- Workload subnet
- Network Security Groups
- Windows and/or Linux workloads
- Microsoft Entra ID users and groups
- Azure RBAC assignments
- Logging and monitoring
- Security findings and remediation

### Network

- VNet: `10.10.0.0/16`
- Management Subnet: `10.10.1.0/24`
- Workload Subnet: `10.10.2.0/24`

## Planned Project Phases

1. Azure account setup, cost protection, and project planning
2. Azure foundation and resource organization
3. Networking and cloud infrastructure
4. Microsoft Entra ID
5. IAM and least privilege
6. Security misconfiguration and risk assessment
7. Remediation and validation
8. Logging, monitoring, and security investigation
9. PowerShell / Azure CLI automation
10. Final security assessment and portfolio documentation

## Security Assessment Approach

Security findings will be documented using the following process:

**Identify → Assess Risk → Remediate → Validate → Document**

Findings may include areas such as:

- Excessive permissions
- Overly permissive network rules
- Unnecessary public exposure
- Weak role assignments
- Logging gaps
- Other cloud security misconfigurations

Only findings actually identified and tested during the lab will be documented as completed work.

## Cost Management

This project is being designed to use an **Azure for Students** subscription and minimize cloud costs.

Resources will be selected, stopped, deallocated, or deleted as appropriate to prevent unnecessary spending.

## Documentation

As the project develops, this repository will include:

- Architecture documentation
- Security findings
- Remediation evidence
- Screenshots
- Scripts
- Configuration notes
- Lessons learned
- Final security assessment

> This repository documents an active learning project. Features, architecture, and documentation will evolve as the lab is built.

