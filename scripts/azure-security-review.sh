#!/usr/bin/env bash

set -euo pipefail

RG="rg-wi-securitylab-wus"
VNET="vnet-wi-securitylab-wus"

AUDIT_IDENTITY="mi-wi-security-audit"
NETWORK_IDENTITY="mi-wi-network-operator"

echo "========================================"
echo " Wu Industries Azure Security Review"
echo "========================================"
echo

echo "[1] Resource Group"
az group show \
  --name "$RG" \
  --query "{ResourceGroup:name,Location:location}" \
  -o table

echo
echo "[2] Virtual Network"
az network vnet show \
  --resource-group "$RG" \
  --name "$VNET" \
  --query "{VNet:name,AddressSpace:addressSpace.addressPrefixes[0],Location:location}" \
  -o table

echo
echo "[3] Subnet and NSG Associations"
printf "%-20s %-18s %s\n" "SUBNET" "ADDRESS" "NSG"
printf "%-20s %-18s %s\n" "------" "-------" "---"

while IFS=$'\t' read -r subnet address nsg_id; do
    nsg_name="${nsg_id##*/}"
    printf "%-20s %-18s %s\n" "$subnet" "$address" "${nsg_name:-None}"
done < <(
    az network vnet subnet list \
      --resource-group "$RG" \
      --vnet-name "$VNET" \
      --query "[].[name,addressPrefix,networkSecurityGroup.id]" \
      -o tsv
)

echo
echo "[4] Management NSG Rules"
az network nsg rule list \
  --resource-group "$RG" \
  --nsg-name nsg-management \
  --query "[].{Name:name,Priority:priority,Access:access,Protocol:protocol,Source:sourceAddressPrefix,Port:destinationPortRange}" \
  -o table

echo
echo "[5] Workload NSG Rules"
az network nsg rule list \
  --resource-group "$RG" \
  --nsg-name nsg-workload \
  --query "[].{Name:name,Priority:priority,Access:access,Protocol:protocol,Source:sourceAddressPrefix,Port:destinationPortRange}" \
  -o table

echo
echo "[6] RBAC Assignments"

AUDIT_ID=$(az identity show \
  --resource-group "$RG" \
  --name "$AUDIT_IDENTITY" \
  --query principalId \
  -o tsv)

NETWORK_ID=$(az identity show \
  --resource-group "$RG" \
  --name "$NETWORK_IDENTITY" \
  --query principalId \
  -o tsv)

echo
echo "$AUDIT_IDENTITY:"
az role assignment list \
  --assignee "$AUDIT_ID" \
  --resource-group "$RG" \
  --query "[].{Role:roleDefinitionName}" \
  -o table

echo
echo "$NETWORK_IDENTITY:"
az role assignment list \
  --assignee "$NETWORK_ID" \
  --resource-group "$RG" \
  --query "[].{Role:roleDefinitionName}" \
  -o table

echo
echo "[7] Security Checks"

SSH_SOURCE=$(az network nsg rule show \
  --resource-group "$RG" \
  --nsg-name nsg-workload \
  --name Allow-Management-SSH \
  --query sourceAddressPrefix \
  -o tsv)

if [[ "$SSH_SOURCE" == "10.10.1.0/24" ]]; then
    echo "[PASS] SSH is restricted to the management subnet."
else
    echo "[WARNING] SSH source is $SSH_SOURCE"
fi

if az network nsg rule show \
  --resource-group "$RG" \
  --nsg-name nsg-workload \
  --name TEMP-Allow-SSH-Any \
  >/dev/null 2>&1; then

    echo "[WARNING] TEMP-Allow-SSH-Any still exists."
else
    echo "[PASS] Temporary unrestricted SSH rule is not present."
fi

NETWORK_ROLES=$(az role assignment list \
  --assignee "$NETWORK_ID" \
  --resource-group "$RG" \
  --query "[].roleDefinitionName" \
  -o tsv)

if echo "$NETWORK_ROLES" | grep -Fxq "Contributor"; then
    echo "[WARNING] Network operator still has the broad Contributor role."
else
    echo "[PASS] Broad Contributor role is not assigned to the network operator."
fi

echo
echo "========================================"
echo " Security review complete"
echo "========================================"
