# Module 4: Cisco Intersight Standalone Mode (ISM) for Nutanix

Cisco Intersight Standalone Mode (ISM) allows for management and automation of Nutanix nodes without the requirement of physical Fabric Interconnects.

## 1. Hardware & Cabling Requirements
For ISM deployments, Nutanix supports specific cabling topologies for C-Series standalone servers:
* **Adapter Configuration**: Supports 2-port and 4-port NIC/VIC configurations (e.g., VIC 1542x).
* **Redundancy**: Dual-adapter setups are recommended to provide hardware-level path redundancy.

## 2. CIMC & Host Preparation
Before onboarding servers into Intersight, the Cisco Integrated Management Controller (CIMC) must be prepared:
* **IP Connectivity**: Configure static IPs or DHCP for CIMC management access.
* **Core Services**: Stable integration requires accurate DNS and NTP configurations to maintain time-sync for API operations.

## 3. Intersight Onboarding Workflow
1. **Target Claiming**: Use the Intersight dashboard to claim standalone servers into your organization.
2. **API Keys**: Generate v3 API keys within Intersight. These are essential for allowing **Nutanix Foundation Central** to orchestrate the hardware.
3. **Software Access**: Enable software download access within Intersight to facilitate firmware updates via LCM.

## 4. Prism & Foundation Central Setup
Foundation Central provides the "Zero-Touch" deployment layer for ISM clusters.
* **Deployment**: Deploy Prism Central (PC) version 2023.3 or higher.
* **API Integration**: Link PC to Intersight using the generated API keys to discover unconfigured "bare-metal" nodes.
* **Network Automation**: Ensure the deployment network supports the automated imaging requirements (DHCP Option 200/201 for FC IP and API keys).
