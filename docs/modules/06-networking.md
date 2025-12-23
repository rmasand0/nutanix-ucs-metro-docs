# Module 6: Metro-Ready Network Design

A stable, high-performance network is the foundation of Nutanix Metro Availability. This module covers the critical configurations required on Cisco UCS, Cisco Nexus, and the Inter-Site Link (ISL) to support synchronous replication.

---

## 6.1 Inter-Site Connectivity Requirements
Metro Availability requires a reliable Inter-Site Link (ISL) to handle the real-time mirroring of data between Site A and Site B.

* **Latency Threshold**: The Round Trip Time (RTT) between sites must not exceed **5ms**. High latency directly impacts application "Write" performance due to the Double-ACK requirement.
* **Bandwidth Sizing**: The link must be sized to handle **1.2x the peak write workload** of the applications to account for metadata overhead and resync operations.
* **Layer 2 Extension**: Metro requires stretched Layer 2 networks for the CVM, Hypervisor, and protected VM traffic. This is typically achieved via **VXLAN EVPN** or **OTV** on the Cisco Nexus backbone.



---

## 6.2 MTU and Jumbo Frames Deep Dive
Proper Maximum Transmission Unit (MTU) settings are vital for replication efficiency and reducing CPU overhead on the CVMs.

* **End-to-End Consistency**: An MTU of **9000** (Jumbo Frames) must be configured on:
    1.  **Nutanix CVM & Host vSwitch**
    2.  **Cisco UCS vNIC Policy** (MTU within the QoS Policy)
    3.  **Cisco Fabric Interconnect** (Global QoS Class)
    4.  **Cisco Nexus ToR Switches**
    5.  **ISP/WAN ISL Equipment**
* **Fragmentation Risks**: If any hop in the path is set to 1500 while others are 9000, packets will fragment. In a synchronous environment, this leads to **Replication Timeouts** and can cause the Metro Protection Domain to automatically "Suspend," dropping the cluster into an asynchronous state.

---

## 6.3 Cisco UCS Networking & vPC Design
For deployments using Fabric Interconnects (IMM or UCSM), the following Cisco-specific best practices apply:

* **Virtual Port Channels (vPC)**: Use vPC on the upstream Cisco Nexus switches to provide redundant, high-bandwidth paths.
    * **Configuration**: Fabric Interconnects should be connected via **LACP Port Channels**.
* **VLAN Trunking**: Configure all server-facing ports as 802.1Q trunks. 
    * **Native VLAN**: Ensure the Native VLAN is consistent across the FI and Nexus to avoid "VLAN Mismatch" errors that can drop Management traffic.
* **LACP Policy (The Nutanix "Bridge" Logic)**: 
    * **Phase 1**: Initial imaging uses `active-backup` (no LACP required on Nexus).
    * **Phase 2**: Post-deployment, configure the Nutanix Bond to `balance-tcp` and enable `lacp graceful-convergence` on the Cisco Nexus ports.



---

## 6.4 Traffic Isolation and QoS
To prevent "Bully" traffic (like a massive VM backup) from starving the Metro Replication traffic, isolation is mandatory.

* **Separating Replication**: In a Nutanix environment, the **Backplane Network** handles replication. If using Cisco VICs, consider using separate vNICs for Management and Storage traffic to provide physical-level air-gapping within the Fabric.
* **Cisco UCS QoS Classes**: 
    * Assign the **Nutanix Backplane/Storage** traffic to a "Platinum" or "Priority" Class.
    * Assign **User VM** traffic to a "Silver" or "Best Effort" Class.
    * This ensures that during a period of high congestion, the Fabric Interconnect will prioritize the "Double-ACK" replication packets.



---

## 6.5 Witness Network Path
The **Nutanix Witness VM** (at Site C) must have network reachability to both Site A and Site B CVMs.
* **Path Diversity**: Ensure the Witness traffic does not share the same physical ISL as the Metro Replication traffic. If the ISL fails, the Witness must still be able to communicate with both sites to determine which site should be promoted to "Active."

---

### 💡 Verification: The Ping Test
Before enabling Metro Availability, perform a Jumbo Frame ping test from a Site A CVM to a Site B CVM:
```bash
ping -s 8972 -M do [Remote_CVM_IP]
