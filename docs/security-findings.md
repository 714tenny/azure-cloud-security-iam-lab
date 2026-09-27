# Wu Industries — Azure Security Findings

This document records security findings identified during the Azure Cloud Security & IAM Lab.

Each finding follows the process:

**Identify → Assess Risk → Remediate → Validate**

Only findings that were actually created, identified, remediated, and validated during the lab are documented here.

---

# Finding 001 — Overly Permissive SSH Access

## Status

**Remediated and Validated**

## Affected Resource

- Network Security Group: `nsg-workload`
- Protected subnet: `snet-workload`

## Finding

A temporary inbound Network Security Group rule was configured that allowed SSH access on TCP port `22` from any source.

Temporary rule:

- Name: `TEMP-Allow-SSH-Any`
- Priority: `120`
- Source: `Any`
- Destination: `Any`
- Protocol: `TCP`
- Destination port: `22`
- Action: `Allow`

## Risk Assessment

**Risk Level: High**

Allowing SSH from any source unnecessarily increases the attack surface of systems protected by the Network Security Group.

Potential risks include:

- Unauthorized SSH connection attempts
- Brute-force attacks
- Credential attacks
- Increased exposure of administrative services
- Access attempts from untrusted networks

Administrative access should be restricted to known and authorized management networks.

## Evidence — Finding

`docs/evidence/12-finding-overly-permissive-ssh.png`

The evidence shows the temporary rule allowing SSH access from any source.

## Remediation

The overly permissive rule was deleted.

The existing least-privilege SSH rule was retained:

- Name: `Allow-Management-SSH`
- Priority: `100`
- Source: `10.10.1.0/24`
- Protocol: `TCP`
- Destination port: `22`
- Action: `Allow`

This limits SSH access to the Wu Industries management subnet.

## Evidence — Remediation

`docs/evidence/13-remediation-ssh-restricted.png`

The evidence shows that SSH is restricted to the management subnet and the temporary permissive rule is no longer present.

## Validation

Azure Cloud Shell and Azure CLI were used to validate the final Network Security Group configuration.

Validation confirmed:

- `TEMP-Allow-SSH-Any` was removed.
- `Allow-Management-SSH` remains configured.
- SSH access is restricted to `10.10.1.0/24`.
- Other Virtual Network inbound traffic remains restricted by `Deny-Other-VNet-Inbound`.

## Evidence — Validation

`docs/evidence/14-ssh-remediation-cli-validation.png`

## Final Result

The overly permissive SSH rule was successfully identified, assessed, removed, and validated.

The final configuration follows a least-privilege approach by limiting administrative SSH access to the designated management subnet.
---

# Finding 002 — Excessive RBAC Permissions

## Status

**Remediated and Validated**

## Affected Identity

- Managed Identity: `mi-wi-network-operator`
- Scope: `rg-wi-securitylab-wus`

## Finding

The network operator managed identity was temporarily assigned the broad Azure `Contributor` role at the resource-group scope.

The identity already had the more appropriate:

- `Network Contributor`

role for its intended job function.

The additional `Contributor` assignment therefore granted permissions beyond what were required.

## Risk Assessment

**Risk Level: High**

The `Contributor` role provides broad resource-management permissions across the assigned scope.

For an identity whose responsibility is limited to Azure networking, this violates the principle of least privilege.

Potential risks include:

- Unauthorized modification of non-network resources
- Accidental resource deletion
- Unnecessary administrative capability
- Increased impact if the identity were compromised
- Reduced separation of duties

## Evidence — Finding

`docs/evidence/15-finding-excessive-rbac-permissions.png`

The evidence shows `mi-wi-network-operator` assigned the broader `Contributor` role.

## Remediation

The excessive `Contributor` role assignment was removed.

The identity retained only:

- Role: `Network Contributor`
- Scope: `rg-wi-securitylab-wus`

This provides the permissions required to manage networking resources without granting broader resource-management access.

## Evidence — Remediation

`docs/evidence/16-remediation-rbac-least-privilege.png`

## Validation

Azure Cloud Shell and Azure CLI were used to verify the final RBAC configuration.

Validation confirmed that:

- `Contributor` was removed.
- `Network Contributor` remained assigned.
- The assignment remained scoped to the Wu Industries resource group.

## Evidence — Validation

`docs/evidence/17-rbac-remediation-cli-validation.png`

## Final Result

The excessive RBAC assignment was successfully identified, assessed, removed, and validated.

The final configuration follows the principle of least privilege by granting the network operator only the Azure networking permissions required for its job function.
