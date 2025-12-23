# Module 5: Nutanix AOS Installation on Cisco UCS

This module details the imaging and cluster creation workflows required to prepare Cisco UCS hardware for a Nutanix Metro environment. It focuses on automating the installation using the Foundation toolset and ensuring hardware-software alignment.

---

## 5.1 IMM (Intersight Managed Mode) Workflow
IMM leverages a modern, cloud-native management approach using Unified Policies to define server identity and network connectivity.

* **Domain Profiles**: Fabric Interconnects are managed via Domain Profiles. For Metro environments, ensure the Inter-Fabric Links (IFL) and Uplink Port Channels are identical across Site A and Site B to maintain configuration symmetry.
* **Policy Templates**: Engineers must define VLANs (Management, Storage, and vMotion), MAC pools, and IP pools globally. 
* **Foundation Central**: This cloud-based portal orchestrates the imaging. 
    * **Requirement**: The Cisco VIC must be configured with a "Virtual Media" policy that points to the Nutanix Foundation ISO.
    * **Automation**: IMM allows for "One-Click" firmware updates integrated into the imaging workflow, ensuring the UCS BIOS and VIC drivers match the Nutanix HCL before AOS is installed.



---

## 5.2 ISM (Standalone Mode) Workflow
The standalone workflow is designed for C-Series servers operating without Fabric Interconnects, utilizing Intersight for orchestration.

* **Node Onboarding**: Individual nodes are claimed via Device ID/Claim Code. Ensure the **Intersight Assist VM** is reachable if deploying in an air-gapped or restricted environment.
* **Intersight API Integration (v3)**: To automate imaging in ISM, you must generate a **v3 API Key/Secret** in Intersight. This allows the local Foundation VM to "speak" to Intersight and mount the ISOs via the CIMC vMedia interface without manual intervention.
* **VLAN Trunking**: Upstream Nexus switchports must be configured as **802.1Q trunks**. 
    * **Critical**: The Native VLAN on the Cisco switchport must match the Nutanix "untagged" management network for the initial node discovery (IPv6 Link-Local).

---

## 5.3 UCSM (Classic Managed Mode) Workflow
For customers utilizing traditional 6400/6500 Fabric Interconnects with the UCS Manager interface:

* **FI Initialization**: Verify that the Fabric Interconnects are in **Subordinate/Primary** roles and that the L1/L2 links are synchronized.
* **Service Profile Templates**: Create a "Nutanix-Specific" template. 
    * **vNIC Placement**: Map eth0 to Fabric A and eth1 to Fabric B. 
    * **C-States**: Explicitly set to "Disabled" in the BIOS policy to prevent performance jitter during Metro synchronous replication.
* **Foundation VM (Local)**: If cloud-based Foundation Central is not used, a local Foundation VM must be placed on the same Layer 2 segment as the UCS Management VLAN.



---

## 5.4 Installation Best Practices & Guardrails
To ensure a successful deployment and prevent "imaging hangs," adhere to these critical technical guardrails:

* **LACP Timing (The "Wait" Rule)**: 
    * **Cisco Side**: Keep port channels in "Active" mode but do not force LACP until the cluster is fully formed.
    * **Nutanix Side**: The default bond mode is `active-backup`. Do not change to `balance-tcp` (LACP) until the CVMs are up and reachable.
* **Network Verification (MTU 9000)**: 
    * Ensure the Jumbo Frames policy is assigned to the UCS **QoS Policy** and applied to the vNICs *before* imaging. If the CVM images with MTU 1500 but the network expects 9000, internal cluster communication will fail.
* **Storage Controller Discovery**: 
    * Confirm the Storage Controller is in **HBA/Pass-through** mode. If Foundation cannot see the individual SSDs/NVMe drives, the "Storage Node" check will fail during the pre-imaging validation.

---

### 💡 Verification Command
Once imaging is complete, log into any CVM via SSH and run the following to verify the cluster was created successfully on the UCS hardware:
```bash
cluster status | grep -i "state"
