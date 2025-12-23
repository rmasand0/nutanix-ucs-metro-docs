# Module 5: Nutanix AOS Installation on Cisco UCS

This module details the imaging and cluster creation workflows required to prepare Cisco UCS hardware for a Nutanix Metro environment.

## 5.1 IMM (Intersight Managed Mode) Workflow
IMM leverages a modern, cloud-native management approach using Unified Policies to define server identity and network connectivity.
* **Domain Profiles**: Fabric Interconnects are managed via Domain Profiles to ensure site-to-site configuration consistency.
* **Policy Templates**: Engineers must define VLANs, MAC pools, and IP pools globally before applying them to specific server slots.
* **Foundation Central**: This cloud-based portal orchestrates the imaging of both the hypervisor and AOS software over the network.



## 5.2 ISM (Standalone Mode) Workflow
The standalone workflow is designed for C-Series servers operating without Fabric Interconnects.
* **Node Onboarding**: Individual nodes are claimed into the Intersight inventory via their Device ID and Claim Code.
* **Cluster Wizard**: The automated wizard handles the deployment of the Nutanix software across all nodes in the inventory group.
* **VLAN Trunking**: Upstream switchports must be configured as trunks to carry traffic for the CVM, Hypervisor, and User VMs.

## 5.3 UCSM (Classic Managed Mode) Workflow
For customers utilizing traditional 6400/6500 Fabric Interconnects:
* **FI Initialization**: Ensure the Fabric Interconnect cluster is healthy and the L1/L2 links are synchronized.
* **Service Profiles**: Instantiate Service Profiles from a Nutanix-optimized template to ensure critical BIOS settings, such as C-States, are disabled.
* **Foundation VM**: Use a standalone Foundation VM to orchestrate the imaging process locally if cloud-based tools are not utilized.

## 5.4 Installation Best Practices
To ensure a successful deployment, adhere to these critical guardrails:
* **LACP Timing**: Do not enable LACP on the Cisco side until the Nutanix imaging and initial cluster creation are complete.
* **Network Verification**: Confirm that the native VLAN is correctly mapped to the CVM and Host network to prevent communication loss during imaging.
