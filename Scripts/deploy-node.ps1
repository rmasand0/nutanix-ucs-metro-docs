# =========================================================================================
# Script: deploy-node.ps1
# Description: Automates Cisco UCS Service Profile creation for Nutanix Metro Nodes.
# Reference: Module 5 (Installation) & Module 2 (Metro Overview)
# =========================================================================================

<#
.SYNOPSIS
    This script instantiates a Service Profile from a Nutanix-optimized template.
    It ensures BIOS settings (C-States disabled) and vNIC settings (MTU 9000) 
    are applied consistently across Site A and Site B.
#>

# --- Configuration Variables ---
$UcsAddress = "10.10.10.50"               # Replace with your Fabric Interconnect IP
[cite_start]$TemplateName = "Nutanix-Metro-Template"  # Must match your UCS Template [cite: 52]
$NodeNamePrefix = "NX-METRO-S1-N"         # Naming convention for Site 1
$TargetChassis = "1"
$TargetSlot = "1"

# --- Connect to UCS Manager ---
Import-Module Cisco.Ucs.PowerTool -ErrorAction SilentlyContinue
Connect-Ucs $UcsAddress

Write-Host "--- Starting Nutanix Node Deployment ---" -ForegroundColor Cyan

# 1. Verify Template 
$Template = Get-UcsServiceProfile -Name $TemplateName -Type "initial-template"
if (-not $Template) {
    Write-Error "Template $TemplateName not found. Check Module 5 for template requirements."
    exit
}

# 2. Create Service Profile from Template
$NewProfileName = "$NodeNamePrefix$TargetSlot"
Write-Host "Creating Profile: $NewProfileName"
$Profile = Add-UcsServiceProfile -Name $NewProfileName -SrcTemplName $TemplateName

# 3. Associate with Physical Blade
Write-Host "Associating with Chassis $TargetChassis Slot $TargetSlot..."
$Blade = Get-UcsBlade -ChassisId $TargetChassis -SlotId $TargetSlot
$Profile | Set-UcsServiceProfile -PnDn $Blade.Dn -Confirm:$false

# 4. Monitor Status
do {
    $Status = (Get-UcsServiceProfile -Name $NewProfileName).AssocState
    Write-Host "Current Status: $Status"
    Start-Sleep -Seconds 30
} while ($Status -ne "associated")

Write-Host "--- Deployment Complete. Ready for Nutanix Foundation ---" -ForegroundColor Green
Disconnect-Ucs
