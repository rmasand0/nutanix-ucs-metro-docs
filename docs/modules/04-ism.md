# Module 4: Cisco Intersight Standalone Mode (ISM) for Nutanix

---

## 4.1 Introduction to Standalone Management
Cisco Intersight Standalone Mode (ISM) allows for the centralized management of Nutanix nodes without the requirement for physical Fabric Interconnects. This architecture is ideal for smaller footprints or edge deployments where policy-driven consistency is still required for standalone C-Series servers.

---

## 4.2 Hardware and Cabling Requirements
To ensure the stability and performance required for Metro Availability, standalone nodes must adhere to specific cabling and adapter standards:
* **Connectivity**: Servers connect directly to upstream Top-of-Rack (ToR) switches using 10GbE, 25GbE, or 100GbE ports.
* **VIC Support**: Deployment is supported on Cisco VIC 14000 and 15000 series adapters.
* **High Availability**: For mission-critical Metro workloads, dual-adapter configurations are utilized to eliminate single points of failure at the card level.



---

## 4.3 BIOS Performance Deep Dive
For Nutanix Metro Availability, BIOS tuning is critical to minimize latency in the synchronous replication path. In ISM, these settings are typically applied via a **Server Profile** in Intersight:

* **Processor Configuration**: 
    * **Hyper-Threading**: Enabled.
    * **Virtualization Technology (VT-x)**: Enabled.
    * **Hardware Prefetcher**: Enabled.
* **Power & Performance**: 
    * **CPU Performance**: Set to **Enterprise** or **High Performance**.
    * **Energy Performance**: Set to **Performance**.
    * **C-States**: **Disabled**. (Crucial: Prevents CPU sleep states from delaying I/O acknowledgments between Metro sites).

---

## 4.4 Storage Controller & Pass-through (HBA Mode)
Nutanix AOS requires direct control over the physical drives to manage data locality and redundancy (Nutanix RF2/RF3).
* **Controller Mode**: The Cisco 12G Modular RAID controller must be configured in **JBOD/Pass-through Mode**.
* **Boot Device**: Use the **Cisco Boot Optimized M.2 RAID Controller** (dual M.2 SSDs in RAID 1) to host the Hypervisor (AHV/ESXi). This keeps the main data drives dedicated to the Nutanix Storage Tier.
* **Drive Visibility**: Ensure all front-loading NVMe/SSD drives are in an "Unconfigured Good" state before starting the Foundation process.



---

## 4.5 CIMC and Host Preparation
The Cisco Integrated Management Controller (CIMC) serves as the local management interface that connects the server to the Intersight cloud.
* **Initial Setup**: Configure CIMC with a static IP or DHCP to allow for the initial claiming process.
* **Core Services**: Accurate DNS and NTP settings are mandatory to ensure certificate validation and time-stamping for replication logs remain synchronized.
* **Intersight Claiming**: Servers are "claimed" into the Intersight dashboard using their unique Device ID and Claim Code.
* **API Integration**: v3 API keys are generated within Intersight to allow the Nutanix Foundation process to communicate with the hardware for automated imaging.

---

## 4.6 Management Comparison
During the workshop, we compare ISM to IMM to help engineers choose the right path for their specific Nutanix deployment:

| Feature | Intersight Standalone (ISM) | Intersight Managed (IMM) |
| :--- | :--- | :--- |
| **Fabric Interconnects** | Not Required | Required |
| **Control Plane** | CIMC (Direct to Intersight) | UCS Domain (via FI) |
| **Policy Scope** | Individual Server | Global Domain / Templates |
| **Scale** | Edge / Small / Medium | Large / Enterprise |

---
