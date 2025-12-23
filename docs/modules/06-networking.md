# Module 6: Metro-Ready Network Design

A stable, high-performance network is the foundation of Nutanix Metro Availability. This module covers the critical configurations required on Cisco UCS and upstream switches to support synchronous replication.

## 6.1 Inter-Site Connectivity Requirements
Metro Availability requires a reliable Inter-Site Link (ISL) to handle the real-time mirroring of data.
* **Latency Threshold**: The Round Trip Time (RTT) between sites must not exceed 5ms.
* **Bandwidth Sizing**: The link must be sized to handle 1.2x the peak write workload of the applications to account for metadata overhead.
* **Layer 2 Extension**: Metro requires stretched Layer 2 networks for the CVM, Hypervisor, and protected VM traffic.

## 6.2 MTU and Jumbo Frames
Proper Maximum Transmission Unit (MTU) settings are vital for replication efficiency and reducing CPU overhead on the CVMs.
* **End-to-End Consistency**: An MTU of 9000 (Jumbo Frames) must be configured on all virtual and physical interfaces in the replication path.
* **Fragmentation Risks**: Inconsistent MTU settings lead to packet fragmentation, which significantly increases latency and can cause replication timeouts.



## 6.3 Cisco UCS Networking & vPC Design
For deployments using Fabric Interconnects, the following Cisco best practices apply:
* **Virtual Port Channels (vPC)**: Use vPC on the upstream Cisco Nexus switches to provide redundant, high-bandwidth paths to the Fabric Interconnects.
* **VLAN Trunking**: Configure all server-facing ports as 802.1Q trunks to allow multiple traffic types (Management, Storage, and VM) to flow over the same physical links.
* **LACP Policy**: While LACP is recommended for production, it should be disabled during the initial Nutanix Foundation imaging process and enabled only after the cluster is formed.

## 6.4 Traffic Isolation and QoS
* **Separating Replication**: Whenever possible, isolate synchronous replication traffic to dedicated physical or virtual links to prevent congestion from general VM traffic.
* **Quality of Service (QoS)**: Implement "Silver" or "Platinum" UCS QoS classes to prioritize storage traffic over the Fabric Interconnects.
