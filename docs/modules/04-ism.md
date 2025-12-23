# Module 4: Cisco Intersight Standalone Mode (ISM) for Nutanix

## 4.1 Introduction to Standalone Management
Cisco Intersight Standalone Mode (ISM) allows for the centralized management of Nutanix nodes without the requirement for physical Fabric Interconnects. This architecture is ideal for smaller footprints or edge deployments where policy-driven consistency is still required for standalone C-Series servers.

## 4.2 Hardware and Cabling Requirements
To ensure the stability and performance required for Metro Availability, standalone nodes must adhere to specific cabling and adapter standards:
* **Connectivity**: Servers connect directly to upstream Top-of-Rack (ToR) switches using 10GbE, 25GbE, or 100GbE ports.
* **VIC Support**: Deployment is supported on Cisco VIC 14000 and 15000 series adapters.
* **High Availability**: For mission-critical Metro workloads, dual-adapter configurations are utilized to eliminate single points of failure at the card level.



## 4.3 CIMC and Host Preparation
The Cisco Integrated Management Controller (CIMC) serves as the local management interface that connects the server to the Intersight cloud.
* **Initial Setup**: Configure CIMC with a static IP or DHCP to allow for the initial claiming process.
* **Core Services**: Accurate DNS and NTP settings are mandatory to ensure certificate validation and time-stamping for replication logs remain synchronized.
* **Intersight Claiming**: Servers are "claimed" into the Intersight dashboard using their unique Device ID and Claim Code.
* **API Integration**: v3 API keys are generated within Intersight to allow the Nutanix Foundation process to communicate with the hardware for automated imaging.

## 4.4 Management Comparison
During the workshop, we compare ISM to IMM to help engineers choose the right path:
| Feature | Intersight Standalone (ISM) | Intersight Managed (IMM) |
| :--- | :--- | :--- |
| **Fabric Interconnects** | Not Required | Required |
| **Policy Scope** | Individual Server | Global Domain |
| **Scale** | Edge / Small / Medium | Large / Enterprise |
